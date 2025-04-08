// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {Script, console} from "forge-std/Script.sol";
import {HJB} from "../src/HJB.sol";


// forge script script/HJB.s.sol:HJBScript --rpc-url http://localhost:8545 --broadcast
contract HJBScript is Script {
    HJB public hjb;
    address public recipient;
    address public initialOwner;

    function setUp() public {
        recipient = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
        initialOwner = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    }

    function run() public {
        uint256 privateKey = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
        vm.startBroadcast(privateKey);
        hjb = new HJB(recipient, initialOwner);
        console.log("HJB deployed to:", address(hjb));
        vm.stopBroadcast();
    }
}
