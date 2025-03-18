// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract MyContract {
    string public message;

    constructor(string memory _message) {
        message = _message;
    }
}
