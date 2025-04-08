// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {Test, console} from "forge-std/Test.sol";
import {HJB} from "../src/HJB.sol";
import "../dependencies/openzeppelin-contracts/contracts/access/Ownable.sol";

contract HJBTest is Test {
    HJB public hjb;
    address recipient = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    address initialOwner = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;

    function setUp() public {
        vm.startPrank(initialOwner);
        hjb = new HJB(recipient, initialOwner);
        vm.stopPrank();
    }

//    function test_pause() public {
//        vm.expectEmit(true);
//        // The event we expect
//        emit hjb.Paused(recipient);
//        hjb.pause();
//    }

    function test_mint() public {
        uint256 amountToMint = 100;
        uint256 initialBalance = hjb.balanceOf(recipient);

        vm.startPrank(initialOwner);
        hjb.mint(recipient, amountToMint);
        vm.stopPrank();

        uint256 finalBalance = hjb.balanceOf(recipient);

        assertEq(finalBalance, initialBalance + amountToMint, "Balance should increase by the minted amount");
    }

    function test_mint_not_owner() public {
        uint256 amountToMint = 100;
        address nonOwner = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;

        vm.expectRevert(abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, nonOwner));
        vm.prank(nonOwner);
        hjb.mint(recipient, amountToMint);
    }
}
