// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Counter {

    error Unauthorized();

    address public immutable owner;

    uint256 public number;

    constructor() {
        owner = msg.sender;
    }

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        if (msg.sender != owner) {
            revert Unauthorized();
        }
        number++;
    }

    function count() external view returns (uint256) {
        return number;
    }

    function subtract() external returns (uint256){
        return number--;
    }
}
