// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;


contract Create2Factory {

    event Deployed(address addr);

    function deploy(bytes memory bytecode, bytes32 salt) external payable {
        address addr;
        assembly {
            addr := create2(
                callvalue(),     // 发送的ETH
                add(bytecode, 0x20), // 跳过bytecode的长度部分
                mload(bytecode), // bytecode长度
                salt             // salt
            )
            if iszero(extcodesize(addr)) {
                revert(0, 0)
            }
        }
        emit Deployed(addr);
    }

    function computeAddress(bytes32 salt, bytes32 bytecodeHash) external view returns (address) {
        return address(uint160(uint256(keccak256(abi.encodePacked(
            bytes1(0xff),
            address(this), // 工厂合约地址
            salt,
            bytecodeHash
        )))));
    }
}
