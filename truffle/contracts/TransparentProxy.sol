// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract TransparentProxy {
    address public implementation;
    address public admin;
    string public words;

    constructor(address _initImpl) {
        admin = msg.sender;
        implementation = _initImpl;
    }

    // 升级函数，改变逻辑合约地址，只能由admin调用
    function upgrade(address newImpl) external {
        if (msg.sender != admin) revert();
        implementation = newImpl;
    }

    // fallback函数，将调用委托给逻辑合约
    // 不能被admin调用，避免选择器冲突引发意外
    fallback() external payable {
        require(msg.sender != admin);
        (bool success, bytes memory data) = implementation.delegatecall(
            msg.data
        );
        // 如果调用失败，抛出异常
        if (!success) {
            assembly {
                revert(add(data, 32), mload(data))
            }
        }

        // 如果调用成功，返回逻辑合约的返回值
        assembly {
            return (add(data, 32), mload(data))
        }
    }

}

contract Logic1 {
    address public implementation;
    address public admin;
    string public words;

    function foo() public {
        words = "foo";
    }
}

contract Logic2 {
    address public implementation;
    address public admin;
    string public words;

    function foo() public {
        words = "foo2";
    }
}

contract SelectorClash {
    function secretSlector(string memory method) external pure returns (bytes4) {
        return bytes4(keccak256(bytes(method)));
    }

}