// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @notice 向多个地址转账ERC20代币
contract Airdrop {

    /// 失败转账数据
    mapping(address => uint256) public failTransferList;

    function multiTransferToken(
        address _token,
        address[] calldata _addresses,
        uint256[] calldata _amounts
    ) external {
        require(_addresses.length == _amounts.length, "addresses and amounts length mismatch");
        IERC20 token = IERC20(_token);
        uint256 totalAmount = getSum(_amounts);
        require(token.allowance(msg.sender, address(this)) >= totalAmount, "allowance not enough");
        for (uint256 i = 0; i < _addresses.length; i++) {
            token.transferFrom(msg.sender, _addresses[i], _amounts[i]);
        }
    }

    function multiTransferETH(address[] calldata _addresses, uint256[] calldata _amounts) public payable {
        require(_addresses.length == _amounts.length, "addresses and amounts length mismatch");
        uint256 totalAmount = getSum(_amounts);
        require(msg.value >= totalAmount, "insufficient ETH");
        for (uint256 i = 0; i < _addresses.length; i++) {
            (bool success,) = _addresses[i].call{value: _amounts[i]}("");
            if (!success) {
                failTransferList[_addresses[i]] = _amounts[i];
            }
        }
    }

    function withdrawFromFailList(address to) public {
        uint amount = failTransferList[msg.sender];
        require(amount > 0, "no amount");
        failTransferList[msg.sender] = 0;
        (bool success,) = to.call{value: amount}("");
        require(success, "transfer failed");
    }

    // 数组求和函数
    function getSum(uint256[] calldata _arr) public pure returns (uint256 sum) {
        for (uint i = 0; i < _arr.length; i++) sum = sum + _arr[i];
    }

}
