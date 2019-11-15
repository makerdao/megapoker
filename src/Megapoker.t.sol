pragma solidity ^0.5.12;

import "ds-test/test.sol";

import "./Megapoker.sol";

contract MegapokerTest is DSTest {
    Megapoker megapoker;

    function setUp() public {
        megapoker = new Megapoker();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
