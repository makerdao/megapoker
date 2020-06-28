// SPDX-License-Identifier: AGPL-3.0
pragma solidity >=0.5.12;

import "ds-test/test.sol";

import "./Megapoker.sol";

contract MegaPokerTest is DSTest {
    MegaPoker megapoker;

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
