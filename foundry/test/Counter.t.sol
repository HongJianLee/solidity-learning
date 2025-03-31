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
        assert(counter.count() == 0);
        counter.increment();
        assert(counter.count() == 1);
    }

    function test_setNumber() public {
        assert(counter.count() == 0);
        counter.setNumber(10);
        assert(counter.count() == 10);
    }

    function test_subtract() public {
        vm.expectRevert("Expection");
        counter.subtract();
    }
}
