// SPDX-License-Identifier: AGPL-3.0
// The MegaPoker
//
// Copyright (C) 2020 Maker Ecosystem Growth Holdings, INC.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

pragma solidity ^0.6.12;

import "ds-test/test.sol";

import "./MegaPoker.sol";

interface SpellLike {
    function eta() external view returns (uint256);
    function done() external view returns (bool);
    function schedule() external;
    function cast() external;
}

interface ChainLogLike {
    function getAddress(bytes32) external view returns (address);
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

interface OsmLike {
    function read() external view returns (bytes32);
}

interface SpotLike {
    function ilks(bytes32) external view returns (address, uint256);
    function par() external view returns (uint256);
    function vat() external view returns (address);
}

interface VatLike {
    function ilks(bytes32) external view returns (uint256, uint256, uint256, uint256, uint256);
}

interface Hevm {
    function warp(uint256) external;
    function store(address,bytes32,bytes32) external;
}

contract MegaPokerTest is DSTest, PokingAddresses {
    SpellLike    constant spell     = SpellLike(0x530708D653D540B3FcE6dF02da95588834aD39f2);

    ChainLogLike constant changelog = ChainLogLike(0xdA0Ab1e0017DEbCd72Be8599041a2aa3bA7e740F);

    PauseLike pause;
    ChiefLike chief;
    TokenLike govToken;

    Hevm hevm;

    MegaPoker megaPoker;

    bytes20 constant CHEAT_CODE = bytes20(uint160(uint256(keccak256('hevm cheat code'))));

    function setUp() public {
        hevm = Hevm(address(CHEAT_CODE));
        megaPoker = new MegaPoker();
        pause = PauseLike(changelog.getAddress("MCD_PAUSE"));
        chief = ChiefLike(changelog.getAddress("MCD_ADM"));
        govToken = TokenLike(changelog.getAddress("MCD_GOV"));
        hevm.warp(now + 3600);
    }

    function _mul(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x);
    }

    uint256 constant RAY = 10 ** 27;

    function _rdiv(uint x, uint y) internal pure returns (uint z) {
        z = _mul(x, RAY) / y;
    }

    function vote(SpellLike spell_) private {
        if (chief.hat() != address(spell_)) {
            hevm.store(
                address(govToken),
                keccak256(abi.encode(address(this), uint256(1))),
                bytes32(uint256(999999999999 ether))
            );
            govToken.approve(address(chief), uint256(-1));
            chief.lock(999999999999 ether);

            assertTrue(!spell_.done());

            address[] memory yays = new address[](1);
            yays[0] = address(spell_);

            chief.vote(yays);
            chief.lift(address(spell_));
        }
        assertEq(chief.hat(), address(spell_));
    }

    function schedule(SpellLike spell_) public {
        if (spell_.eta() == 0) {
            spell_.schedule();
        }
        assertTrue(spell.eta() > 0);
    }

    function waitAndCast(SpellLike spell_) public {
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
        spell_.cast();
    }

    function test_poke() public {
        if (address(spell) != address(0) && !spell.done()) {
            vote(spell);
            schedule(spell);
            waitAndCast(spell);
        }

        // To update osms without any value yet
        hevm.warp(block.timestamp + 1 hours);
        megaPoker.poke();
        assertEq(megaPoker.last(), block.timestamp);
        hevm.warp(block.timestamp + 1 hours);
        megaPoker.poke();
        assertEq(megaPoker.last(), block.timestamp - 1 hours);

        // Hacking nxt price to 0x123 (and making it valid)
        bytes32 hackedValue = 0x0000000000000000000000000000000100000000000000000000000000000123;
        hevm.store(btc, bytes32(uint256(4)), hackedValue);
        hevm.store(crvv1ethsteth, bytes32(uint256(4)), hackedValue);
        hevm.store(eth, bytes32(uint256(4)), hackedValue);
        hevm.store(guniv3daiusdc1, bytes32(uint256(4)), hackedValue);
        hevm.store(guniv3daiusdc2, bytes32(uint256(4)), hackedValue);
        hevm.store(reth, bytes32(uint256(4)), hackedValue);
        hevm.store(univ2daiusdc, bytes32(uint256(4)), hackedValue);
        hevm.store(wsteth, bytes32(uint256(4)), hackedValue);

        // Whitelisting tester address
        hevm.store(btc, keccak256(abi.encode(address(this), uint256(5))), bytes32(uint256(1)));
        hevm.store(crvv1ethsteth, keccak256(abi.encode(address(this), uint256(2))), bytes32(uint256(1)));
        hevm.store(eth, keccak256(abi.encode(address(this), uint256(5))), bytes32(uint256(1)));
        hevm.store(guniv3daiusdc1, keccak256(abi.encode(address(this), uint256(2))), bytes32(uint256(1)));
        hevm.store(guniv3daiusdc2, keccak256(abi.encode(address(this), uint256(2))), bytes32(uint256(1)));
        hevm.store(reth, keccak256(abi.encode(address(this), uint256(5))), bytes32(uint256(1)));
        hevm.store(univ2daiusdc, keccak256(abi.encode(address(this), uint256(2))), bytes32(uint256(1)));
        hevm.store(wsteth, keccak256(abi.encode(address(this), uint256(5))), bytes32(uint256(1)));

        // 0x123
        hackedValue = 0x0000000000000000000000000000000000000000000000000000000000000123;

        assertTrue(OsmLike(btc).read() != hackedValue);
        assertTrue(OsmLike(eth).read() != hackedValue);
        assertTrue(OsmLike(reth).read() != hackedValue);
        assertTrue(OsmLike(wsteth).read() != hackedValue);

        assertTrue(OsmLike(crvv1ethsteth).read() != hackedValue);
        assertTrue(OsmLike(guniv3daiusdc1).read() != hackedValue);
        assertTrue(OsmLike(guniv3daiusdc2).read() != hackedValue);
        assertTrue(OsmLike(univ2daiusdc).read() != hackedValue);

        hevm.warp(block.timestamp + 1 hours);
        megaPoker.poke();

        assertEq(OsmLike(btc).read(), hackedValue);
        assertEq(OsmLike(eth).read(), hackedValue);
        assertEq(OsmLike(reth).read(), hackedValue);
        assertEq(OsmLike(wsteth).read(), hackedValue);

        // Daily OSM's are not updated after one hour
        assertTrue(OsmLike(crvv1ethsteth).read() != hackedValue);
        assertTrue(OsmLike(guniv3daiusdc1).read() != hackedValue);
        assertTrue(OsmLike(guniv3daiusdc2).read() != hackedValue);
        assertTrue(OsmLike(univ2daiusdc).read() != hackedValue);

        uint256 mat;
        uint256 spot;
        uint256 value = _rdiv(_mul(uint256(hackedValue), 10 ** 9), SpotLike(spotter).par());
        address vat = SpotLike(spotter).vat();

        (, mat) = SpotLike(spotter).ilks("ETH-A");
        (,, spot,,) = VatLike(vat).ilks("ETH-A");
        assertEq(spot, _rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("WBTC-A");
        (,, spot,,) = VatLike(vat).ilks("WBTC-A");
        assertEq(spot, _rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("ETH-B");
        (,, spot,,) = VatLike(vat).ilks("ETH-B");
        assertEq(spot, _rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("ETH-C");
        (,, spot,,) = VatLike(vat).ilks("ETH-C");
        assertEq(spot, _rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("WSTETH-A");
        (,, spot,,) = VatLike(vat).ilks("WSTETH-A");
        assertEq(spot, _rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("WSTETH-B");
        (,, spot,,) = VatLike(vat).ilks("WSTETH-B");
        assertEq(spot, _rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("WBTC-B");
        (,, spot,,) = VatLike(vat).ilks("WBTC-B");
        assertEq(spot, _rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("WBTC-C");
        (,, spot,,) = VatLike(vat).ilks("WBTC-C");
        assertEq(spot, _rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("RETH-A");
        (,, spot,,) = VatLike(vat).ilks("RETH-A");
        assertEq(spot, _rdiv(value, mat));

        // These collateral types should not be updated after 1 hour
        (, mat) = SpotLike(spotter).ilks("CRVV1ETHSTETH-A");
        (,, spot,,) = VatLike(vat).ilks("CRVV1ETHSTETH-A");
        assertTrue(spot != _rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("GUNIV3DAIUSDC1-A");
        (,, spot,,) = VatLike(vat).ilks("GUNIV3DAIUSDC1-A");
        assertTrue(spot != _rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("GUNIV3DAIUSDC2-A");
        (,, spot,,) = VatLike(vat).ilks("GUNIV3DAIUSDC2-A");
        assertTrue(spot != _rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("UNIV2DAIUSDC-A");
        (,, spot,,) = VatLike(vat).ilks("UNIV2DAIUSDC-A");
        assertTrue(spot != _rdiv(value, mat));

        // Daily OSM's are eligible 24 hours after first poked
        hevm.warp(megaPoker.last() + 24 hours);
        megaPoker.poke();
        assertEq(megaPoker.last(), block.timestamp);

        assertEq(OsmLike(guniv3daiusdc1).read(), hackedValue);
        assertEq(OsmLike(guniv3daiusdc2).read(), hackedValue);

        (, mat) = SpotLike(spotter).ilks("GUNIV3DAIUSDC1-A");
        (,, spot,,) = VatLike(vat).ilks("GUNIV3DAIUSDC1-A");
        assertEq(spot, _rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("GUNIV3DAIUSDC2-A");
        (,, spot,,) = VatLike(vat).ilks("GUNIV3DAIUSDC2-A");
        assertEq(spot, _rdiv(value, mat));
    }

    // function testPokeCost() public {
    //     megaPoker.poke();
    // }
}
