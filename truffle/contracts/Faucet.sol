// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Faucet {
    constructor(address _contractAddress) {
        contractAddress = _contractAddress;
    }

    // 每次领 100单位代币
    uint256 public amountAllowed = 100;
    // 合约地址
    address public contractAddress;
    // 领取过代币的地址
    mapping(address => bool) public requestedAddress;

    event SendToken(address indexed _to, uint256 _value);

    // 领代币
    function sendToken() public {
        // 每个地址只能领取一次
        require(!requestedAddress[msg.sender], "You have already requested tokens.");
        // 创建IERC20合约对象
        IERC20 token = IERC20(contractAddress);
        // 水龙头空了
        require(token.balanceOf(address(this)) <= amountAllowed, "Not enough tokens in the faucet.");
        // 发送token
        token.transfer(msg.sender, amountAllowed);
        // 记录领取地址
        requestedAddress[msg.sender] = true;
        emit SendToken(msg.sender, amountAllowed);
    }

}
