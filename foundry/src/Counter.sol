// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Counter {
    uint256 public number;

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }

    function count() external view returns (uint256) {
        return number;
    }

    function subtract() external returns (uint256){
        return number--;
    }
}
