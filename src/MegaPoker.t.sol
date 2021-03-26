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

contract MegaPokerTest is DSTest, Addresses {
    SpellLike    constant spell     = SpellLike(0x4145774D007C88392118f32E2c31686faCc9486E);
    SpellLike    constant prevSpell = SpellLike(address(0));

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
    }

    function mul(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x);
    }

    uint256 constant RAY = 10 ** 27;

    function rdiv(uint x, uint y) internal pure returns (uint z) {
        z = mul(x, RAY) / y;
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
        if (address(prevSpell) != address(0) && !prevSpell.done()) {
            vote(prevSpell);
            schedule(prevSpell);
            waitAndCast(prevSpell);
        }

        // Hacking nxt price to 0x123 (and making it valid)
        bytes32 hackedValue = 0x0000000000000000000000000000000100000000000000000000000000000123;
        hevm.store(eth, bytes32(uint256(4)), hackedValue);
        hevm.store(bat, bytes32(uint256(4)), hackedValue);
        hevm.store(btc, bytes32(uint256(4)), hackedValue);
        hevm.store(knc, bytes32(uint256(4)), hackedValue);
        hevm.store(zrx, bytes32(uint256(4)), hackedValue);
        hevm.store(mana, bytes32(uint256(4)), hackedValue);
        hevm.store(usdt, bytes32(uint256(4)), hackedValue);
        hevm.store(comp, bytes32(uint256(4)), hackedValue);
        hevm.store(link, bytes32(uint256(4)), hackedValue);
        hevm.store(lrc, bytes32(uint256(4)), hackedValue);
        hevm.store(yfi, bytes32(uint256(4)), hackedValue);
        hevm.store(bal, bytes32(uint256(4)), hackedValue);
        hevm.store(uni, bytes32(uint256(4)), hackedValue);
        hevm.store(aave, bytes32(uint256(4)), hackedValue);
        hevm.store(univ2daieth, bytes32(uint256(7)), hackedValue);
        hevm.store(univ2wbtceth, bytes32(uint256(7)), hackedValue);
        hevm.store(univ2usdceth, bytes32(uint256(7)), hackedValue);
        hevm.store(univ2daiusdc, bytes32(uint256(7)), hackedValue);
        hevm.store(univ2ethusdt, bytes32(uint256(7)), hackedValue);
        hevm.store(univ2linketh, bytes32(uint256(7)), hackedValue);
        hevm.store(univ2unieth, bytes32(uint256(7)), hackedValue);
        hevm.store(univ2wbtcdai, bytes32(uint256(7)), hackedValue);
        hevm.store(univ2aaveeth, bytes32(uint256(7)), hackedValue);
        hevm.store(univ2daiusdt, bytes32(uint256(7)), hackedValue);

        // Whitelisting tester address
        hevm.store(eth, keccak256(abi.encode(address(this), uint256(5))), bytes32(uint256(1)));
        hevm.store(bat, keccak256(abi.encode(address(this), uint256(5))), bytes32(uint256(1)));
        hevm.store(btc, keccak256(abi.encode(address(this), uint256(5))), bytes32(uint256(1)));
        hevm.store(knc, keccak256(abi.encode(address(this), uint256(5))), bytes32(uint256(1)));
        hevm.store(zrx, keccak256(abi.encode(address(this), uint256(5))), bytes32(uint256(1)));
        hevm.store(mana, keccak256(abi.encode(address(this), uint256(5))), bytes32(uint256(1)));
        hevm.store(usdt, keccak256(abi.encode(address(this), uint256(5))), bytes32(uint256(1)));
        hevm.store(comp, keccak256(abi.encode(address(this), uint256(5))), bytes32(uint256(1)));
        hevm.store(link, keccak256(abi.encode(address(this), uint256(5))), bytes32(uint256(1)));
        hevm.store(lrc, keccak256(abi.encode(address(this), uint256(5))), bytes32(uint256(1)));
        hevm.store(yfi, keccak256(abi.encode(address(this), uint256(5))), bytes32(uint256(1)));
        hevm.store(bal, keccak256(abi.encode(address(this), uint256(5))), bytes32(uint256(1)));
        hevm.store(uni, keccak256(abi.encode(address(this), uint256(5))), bytes32(uint256(1)));
        hevm.store(aave, keccak256(abi.encode(address(this), uint256(5))), bytes32(uint256(1)));
        hevm.store(univ2daieth, keccak256(abi.encode(address(this), uint256(2))), bytes32(uint256(1)));
        hevm.store(univ2wbtceth, keccak256(abi.encode(address(this), uint256(2))), bytes32(uint256(1)));
        hevm.store(univ2usdceth, keccak256(abi.encode(address(this), uint256(2))), bytes32(uint256(1)));
        hevm.store(univ2daiusdc, keccak256(abi.encode(address(this), uint256(2))), bytes32(uint256(1)));
        hevm.store(univ2ethusdt, keccak256(abi.encode(address(this), uint256(2))), bytes32(uint256(1)));
        hevm.store(univ2linketh, keccak256(abi.encode(address(this), uint256(2))), bytes32(uint256(1)));
        hevm.store(univ2unieth, keccak256(abi.encode(address(this), uint256(2))), bytes32(uint256(1)));
        hevm.store(univ2wbtcdai, keccak256(abi.encode(address(this), uint256(2))), bytes32(uint256(1)));
        hevm.store(univ2aaveeth, keccak256(abi.encode(address(this), uint256(2))), bytes32(uint256(1)));
        hevm.store(univ2daiusdt, keccak256(abi.encode(address(this), uint256(2))), bytes32(uint256(1)));

        hevm.warp(now + 3601);

        // 0x123
        hackedValue = 0x0000000000000000000000000000000000000000000000000000000000000123;

        assertTrue(OsmLike(eth).read() != hackedValue);
        assertTrue(OsmLike(bat).read() != hackedValue);
        assertTrue(OsmLike(btc).read() != hackedValue);
        assertTrue(OsmLike(knc).read() != hackedValue);
        assertTrue(OsmLike(zrx).read() != hackedValue);
        assertTrue(OsmLike(mana).read() != hackedValue);
        assertTrue(OsmLike(usdt).read() != hackedValue);
        assertTrue(OsmLike(comp).read() != hackedValue);
        assertTrue(OsmLike(link).read() != hackedValue);
        assertTrue(OsmLike(lrc).read() != hackedValue);
        assertTrue(OsmLike(yfi).read() != hackedValue);
        assertTrue(OsmLike(bal).read() != hackedValue);
        assertTrue(OsmLike(uni).read() != hackedValue);
        assertTrue(OsmLike(aave).read() != hackedValue);
        assertTrue(OsmLike(univ2daieth).read() != hackedValue);
        assertTrue(OsmLike(univ2wbtceth).read() != hackedValue);
        assertTrue(OsmLike(univ2usdceth).read() != hackedValue);
        assertTrue(OsmLike(univ2daiusdc).read() != hackedValue);
        assertTrue(OsmLike(univ2ethusdt).read() != hackedValue);
        assertTrue(OsmLike(univ2linketh).read() != hackedValue);
        assertTrue(OsmLike(univ2unieth).read() != hackedValue);
        assertTrue(OsmLike(univ2wbtcdai).read() != hackedValue);
        assertTrue(OsmLike(univ2aaveeth).read() != hackedValue);
        assertTrue(OsmLike(univ2daiusdt).read() != hackedValue);

        megaPoker.poke();

        assertEq(OsmLike(eth).read(), hackedValue);
        assertEq(OsmLike(bat).read(), hackedValue);
        assertEq(OsmLike(btc).read(), hackedValue);
        assertEq(OsmLike(knc).read(), hackedValue);
        assertEq(OsmLike(zrx).read(), hackedValue);
        assertEq(OsmLike(mana).read(), hackedValue);
        assertEq(OsmLike(usdt).read(), hackedValue);
        assertEq(OsmLike(comp).read(), hackedValue);
        assertEq(OsmLike(link).read(), hackedValue);
        assertEq(OsmLike(lrc).read(), hackedValue);
        assertEq(OsmLike(yfi).read(), hackedValue);
        assertEq(OsmLike(bal).read(), hackedValue);
        assertEq(OsmLike(uni).read(), hackedValue);
        assertEq(OsmLike(aave).read(), hackedValue);
        assertEq(OsmLike(univ2daieth).read(), hackedValue);
        assertEq(OsmLike(univ2wbtceth).read(), hackedValue);
        assertEq(OsmLike(univ2usdceth).read(), hackedValue);
        assertEq(OsmLike(univ2daiusdc).read(), hackedValue);
        assertEq(OsmLike(univ2ethusdt).read(), hackedValue);
        assertEq(OsmLike(univ2linketh).read(), hackedValue);
        assertEq(OsmLike(univ2unieth).read(), hackedValue);
        assertEq(OsmLike(univ2wbtcdai).read(), hackedValue);
        assertEq(OsmLike(univ2aaveeth).read(), hackedValue);
        assertEq(OsmLike(univ2daiusdt).read(), hackedValue);

        uint256 mat;
        uint256 spot;
        uint256 value = rdiv(mul(uint256(hackedValue), 10 ** 9), SpotLike(spotter).par());
        address vat = SpotLike(spotter).vat();

        (, mat) = SpotLike(spotter).ilks("ETH-A");
        (,, spot,,) = VatLike(vat).ilks("ETH-A");
        assertEq(spot, rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("BAT-A");
        (,, spot,,) = VatLike(vat).ilks("BAT-A");
        assertEq(spot, rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("WBTC-A");
        (,, spot,,) = VatLike(vat).ilks("WBTC-A");
        assertEq(spot, rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("KNC-A");
        (,, spot,,) = VatLike(vat).ilks("KNC-A");
        assertEq(spot, rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("ZRX-A");
        (,, spot,,) = VatLike(vat).ilks("ZRX-A");
        assertEq(spot, rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("MANA-A");
        (,, spot,,) = VatLike(vat).ilks("MANA-A");
        assertEq(spot, rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("USDT-A");
        (,, spot,,) = VatLike(vat).ilks("USDT-A");
        assertEq(spot, rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("COMP-A");
        (,, spot,,) = VatLike(vat).ilks("COMP-A");
        assertEq(spot, rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("LINK-A");
        (,, spot,,) = VatLike(vat).ilks("LINK-A");
        assertEq(spot, rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("LRC-A");
        (,, spot,,) = VatLike(vat).ilks("LRC-A");
        assertEq(spot, rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("ETH-B");
        (,, spot,,) = VatLike(vat).ilks("ETH-B");
        assertEq(spot, rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("YFI-A");
        (,, spot,,) = VatLike(vat).ilks("YFI-A");
        assertEq(spot, rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("BAL-A");
        (,, spot,,) = VatLike(vat).ilks("BAL-A");
        assertEq(spot, rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("RENBTC-A");
        (,, spot,,) = VatLike(vat).ilks("RENBTC-A");
        assertEq(spot, rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("UNI-A");
        (,, spot,,) = VatLike(vat).ilks("UNI-A");
        assertEq(spot, rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("AAVE-A");
        (,, spot,,) = VatLike(vat).ilks("AAVE-A");
        assertEq(spot, rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("UNIV2DAIETH-A");
        (,, spot,,) = VatLike(vat).ilks("UNIV2DAIETH-A");
        assertEq(spot, rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("UNIV2WBTCETH-A");
        (,, spot,,) = VatLike(vat).ilks("UNIV2WBTCETH-A");
        assertEq(spot, rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("UNIV2USDCETH-A");
        (,, spot,,) = VatLike(vat).ilks("UNIV2USDCETH-A");
        assertEq(spot, rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("UNIV2DAIUSDC-A");
        (,, spot,,) = VatLike(vat).ilks("UNIV2DAIUSDC-A");
        assertEq(spot, rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("UNIV2ETHUSDT-A");
        (,, spot,,) = VatLike(vat).ilks("UNIV2ETHUSDT-A");
        assertEq(spot, rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("UNIV2LINKETH-A");
        (,, spot,,) = VatLike(vat).ilks("UNIV2LINKETH-A");
        assertEq(spot, rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("UNIV2UNIETH-A");
        (,, spot,,) = VatLike(vat).ilks("UNIV2UNIETH-A");
        assertEq(spot, rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("UNIV2WBTCDAI-A");
        (,, spot,,) = VatLike(vat).ilks("UNIV2WBTCDAI-A");
        assertEq(spot, rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("UNIV2AAVEETH-A");
        (,, spot,,) = VatLike(vat).ilks("UNIV2AAVEETH-A");
        assertEq(spot, rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("UNIV2DAIUSDT-A");
        (,, spot,,) = VatLike(vat).ilks("UNIV2DAIUSDT-A");
        assertEq(spot, rdiv(value, mat));
        (, mat) = SpotLike(spotter).ilks("ETH-C");
        (,, spot,,) = VatLike(vat).ilks("ETH-C");
        assertEq(spot, rdiv(value, mat));
    }
}
