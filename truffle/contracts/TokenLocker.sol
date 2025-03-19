// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 * @dev ERC20代币时间锁合约。受益人在锁仓一段时间后才能取出代币。
 */
contract TokenLocker {
    event TokenLockStart(
        address indexed beneficiary,
        address indexed token,
        uint256 indexed startTime,
        uint256 lockTime
    );
    event Release(
        address indexed beneficiary,
        address indexed token,
        uint256 indexed releaseTime,
        uint256 amount
    );

    // 被锁仓的ERC20代币合约
    IERC20 public immutable token;
    // 受益人地址
    address public immutable beneficiary;
    // 锁仓时间(秒)
    uint256 public immutable startTime;
    // 锁仓起始时间戳(秒)
    uint256 public immutable lockTime;

    /**
    * @dev 部署时间锁合约，初始化代币合约地址，受益人地址和锁仓时间。
     * @param _token: 被锁仓的ERC20代币合约
     * @param _beneficiary: 受益人地址
     * @param _lockTime: 锁仓时间(秒)
     */
    constructor(
        IERC20 _token,
        address _beneficiary,
        uint256 _lockTime
    ) {
        require(lockTime > 0);
        token = _token;
        beneficiary = _beneficiary;
        startTime = block.timestamp;
        lockTime = _lockTime;
        emit TokenLockStart(beneficiary, address(token), startTime, lockTime);
    }

    /**
     * @dev 在锁仓时间过后，将代币释放给受益人。
     */
    function release() public {
        require(block.timestamp >= startTime+lockTime, "TokenLock: current time is before release time");
        uint256 amount = token.balanceOf(address(this));
        require(amount > 0, "TokenLock: no tokens to release");
        token.transfer(beneficiary, amount);

        emit Release(beneficiary, address(token), block.timestamp, amount);
    }
}

