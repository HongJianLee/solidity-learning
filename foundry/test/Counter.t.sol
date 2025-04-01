// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter counter;

    function setUp() public {
        counter = new Counter();
    }

    function test_increment() public {
        counter.increment();
        assert(counter.count() == 1);
    }
    function test_Revert_IncrementAsNotOwner() public {
        vm.expectRevert(Counter.Unauthorized.selector);
        vm.prank(address(0));
        counter.increment();
    }

    function test_setNumber() public {
        counter.setNumber(10);
        assert(counter.count() == 10);
    }

    function test_subtract() public {
        counter.subtract();
        assert(counter.count() == 9);
    }

    /* beforeTestSetup：可选函数，用于配置在测试之前执行的一组交易。
        bytes4 testSelector 是应用于测试的选择器
        bytes[] memory beforeTestCalldata 是在测试执行之前应用的任意 calldata 数组*/
    function beforeTestSetup(
        bytes4 testSelector
    ) public pure returns (bytes[] memory beforeTestCalldata) {
        if (testSelector == this.test_subtract.selector) {
            beforeTestCalldata = new bytes[](1);
            beforeTestCalldata[0] = abi.encodePacked(this.test_setNumber.selector);
        }
    }
}
