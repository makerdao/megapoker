// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.6.7;

import "ds-test/test.sol";

import "./MegaPoker.sol";

interface SpellLike {
    function eta() external view returns (uint256);
    function done() external view returns (bool);
    function schedule() external;
    function cast() external;
}

interface PauseLike {
    function delay() external view returns (uint256);
}

interface ChiefLike {
    function hat() external view returns (address);
    function lift(address) external;
    function lock(uint256) external; 
    function vote(address[] calldata) external;
}

interface TokenLike {
    function approve(address, uint256) external;
}

interface Hevm {
    function warp(uint256) external;
    function store(address,bytes32,bytes32) external;
}

contract MegaPokerTest is DSTest {
    SpellLike constant spell    = SpellLike(0);

    PauseLike constant pause    = PauseLike(0xbE286431454714F511008713973d3B053A2d38f3);
    ChiefLike constant chief    = ChiefLike(0x9eF05f7F6deB616fd37aC3c959a2dDD25A54E4F5);
    TokenLike constant govToken = TokenLike(0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2);

    Hevm hevm;

    address megaPoker;

    bytes20 constant CHEAT_CODE = bytes20(uint160(uint256(keccak256('hevm cheat code'))));

    function setUp() public {
        hevm = Hevm(address(CHEAT_CODE));

        megaPoker = address(new MegaPoker());
    }

    function vote() private {
        if (chief.hat() != address(spell)) {
            hevm.store(
                address(govToken),
                keccak256(abi.encode(address(this), uint256(1))),
                bytes32(uint256(999999999999 ether))
            );
            govToken.approve(address(chief), uint256(-1));
            chief.lock(999999999999 ether);

            assertTrue(!spell.done());

            address[] memory yays = new address[](1);
            yays[0] = address(spell);

            chief.vote(yays);
            chief.lift(address(spell));
        }
        assertEq(chief.hat(), address(spell));
    }

    function schedule() public {
        if (spell.eta() == 0) {
            spell.schedule();
        }
        assertTrue(spell.eta() > 0);
    }

    function waitAndCast() public {
        uint256 castTime = now + pause.delay();

        uint256 day = (castTime / 1 days + 3) % 7;
        if(day >= 5) {
            castTime += 7 days - day * 86400;
        }

        uint256 hour = castTime / 1 hours % 24;
        if (hour >= 21) {
            castTime += 24 hours - hour * 3600 + 14 hours;
        } else if (hour < 14) {
            castTime += 14 hours - hour * 3600;
        }

        hevm.warp(castTime);
        spell.cast();
    }

    function try_poke() internal returns (bool ok) {
        (ok,) = megaPoker.call(abi.encodeWithSignature("poke()"));
    }

    function try_pokeTemp() internal returns (bool ok) {
        (ok,) = megaPoker.call(abi.encodeWithSignature("poke()"));
    }

    function test_poke() public {
        if (address(spell) != address(0) && !spell.done()) {
            vote();
            schedule();
            assertTrue(try_pokeTemp());
            assertTrue(!try_poke());
            waitAndCast();
        }
        // assertTrue(try_pokeTemp());
        // assertTrue(try_poke());
        try_poke();
        assertTrue(false);
    }
}
