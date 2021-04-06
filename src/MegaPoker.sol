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

contract PokingAddresses {
    // OSMs and Spotter addresses
    address constant eth          = 0x81FE72B5A8d1A857d176C3E7d5Bd2679A9B85763;
    address constant bat          = 0xB4eb54AF9Cc7882DF0121d26c5b97E802915ABe6;
    address constant btc          = 0xf185d0682d50819263941e5f4EacC763CC5C6C42;
    address constant knc          = 0xf36B79BD4C0904A5F350F1e4f776B81208c13069;
    address constant zrx          = 0x7382c066801E7Acb2299aC8562847B9883f5CD3c;
    address constant mana         = 0x8067259EA630601f319FccE477977E55C6078C13;
    address constant usdt         = 0x7a5918670B0C390aD25f7beE908c1ACc2d314A3C;
    address constant comp         = 0xBED0879953E633135a48a157718Aa791AC0108E4;
    address constant link         = 0x9B0C694C6939b5EA9584e9b61C7815E8d97D9cC7;
    address constant lrc          = 0x9eb923339c24c40Bef2f4AF4961742AA7C23EF3a;
    address constant yfi          = 0x5F122465bCf86F45922036970Be6DD7F58820214;
    address constant bal          = 0x3ff860c0F28D69F392543A16A397D0dAe85D16dE;
    address constant uni          = 0xf363c7e351C96b910b92b45d34190650df4aE8e7;
    address constant aave         = 0x8Df8f06DC2dE0434db40dcBb32a82A104218754c;
    address constant univ2daieth  = 0x87ecBd742cEB40928E6cDE77B2f0b5CFa3342A09;
    address constant univ2wbtceth = 0x771338D5B31754b25D2eb03Cea676877562Dec26;
    address constant univ2usdceth = 0xECB03Fec701B93DC06d19B4639AA8b5a838472BE;
    address constant univ2daiusdc = 0x25CD858a00146961611b18441353603191f110A0;
    address constant univ2ethusdt = 0x9b015AA3e4787dd0df8B43bF2FE6d90fa543E13B;
    address constant univ2linketh = 0x628009F5F5029544AE84636Ef676D3Cc5755238b;
    address constant univ2unieth  = 0x8Ce9E9442F2791FC63CD6394cC12F2dE4fbc1D71;
    address constant univ2wbtcdai = 0x5FB5a346347ACf4FCD3AAb28f5eE518785FB0AD0;
    address constant univ2aaveeth = 0x8D34DC2c33A6386E96cA562D8478Eaf82305b81a;
    address constant univ2daiusdt = 0x69562A7812830E6854Ffc50b992c2AA861D5C2d3;
    address constant spotter      = 0x65C79fcB50Ca1594B025960e539eD7A9a6D434A3;
}

contract MegaPoker is PokingAddresses {
    function poke() external {
        bool ok;

        // poke() = 0x18178358
        (ok,) = eth.call(abi.encodeWithSelector(0x18178358));
        (ok,) = bat.call(abi.encodeWithSelector(0x18178358));
        (ok,) = btc.call(abi.encodeWithSelector(0x18178358));
        (ok,) = knc.call(abi.encodeWithSelector(0x18178358));
        (ok,) = zrx.call(abi.encodeWithSelector(0x18178358));
        (ok,) = mana.call(abi.encodeWithSelector(0x18178358));
        (ok,) = usdt.call(abi.encodeWithSelector(0x18178358));
        (ok,) = comp.call(abi.encodeWithSelector(0x18178358));
        (ok,) = link.call(abi.encodeWithSelector(0x18178358));
        (ok,) = lrc.call(abi.encodeWithSelector(0x18178358));
        (ok,) = yfi.call(abi.encodeWithSelector(0x18178358));
        (ok,) = bal.call(abi.encodeWithSelector(0x18178358));
        (ok,) = uni.call(abi.encodeWithSelector(0x18178358));
        (ok,) = aave.call(abi.encodeWithSelector(0x18178358));
        (ok,) = univ2daieth.call(abi.encodeWithSelector(0x18178358));
        (ok,) = univ2wbtceth.call(abi.encodeWithSelector(0x18178358));
        (ok,) = univ2usdceth.call(abi.encodeWithSelector(0x18178358));
        (ok,) = univ2daiusdc.call(abi.encodeWithSelector(0x18178358));
        (ok,) = univ2ethusdt.call(abi.encodeWithSelector(0x18178358));
        (ok,) = univ2linketh.call(abi.encodeWithSelector(0x18178358));
        (ok,) = univ2unieth.call(abi.encodeWithSelector(0x18178358));
        (ok,) = univ2wbtcdai.call(abi.encodeWithSelector(0x18178358));
        (ok,) = univ2aaveeth.call(abi.encodeWithSelector(0x18178358));
        (ok,) = univ2daiusdt.call(abi.encodeWithSelector(0x18178358));

        // poke(bytes32) = 0x1504460f
        (ok,) = spotter.call(abi.encodeWithSelector(0x1504460f, bytes32("ETH-A")));
        (ok,) = spotter.call(abi.encodeWithSelector(0x1504460f, bytes32("BAT-A")));
        (ok,) = spotter.call(abi.encodeWithSelector(0x1504460f, bytes32("WBTC-A")));
        (ok,) = spotter.call(abi.encodeWithSelector(0x1504460f, bytes32("KNC-A")));
        (ok,) = spotter.call(abi.encodeWithSelector(0x1504460f, bytes32("ZRX-A")));
        (ok,) = spotter.call(abi.encodeWithSelector(0x1504460f, bytes32("MANA-A")));
        (ok,) = spotter.call(abi.encodeWithSelector(0x1504460f, bytes32("USDT-A")));
        (ok,) = spotter.call(abi.encodeWithSelector(0x1504460f, bytes32("COMP-A")));
        (ok,) = spotter.call(abi.encodeWithSelector(0x1504460f, bytes32("LINK-A")));
        (ok,) = spotter.call(abi.encodeWithSelector(0x1504460f, bytes32("LRC-A")));
        (ok,) = spotter.call(abi.encodeWithSelector(0x1504460f, bytes32("ETH-B")));
        (ok,) = spotter.call(abi.encodeWithSelector(0x1504460f, bytes32("YFI-A")));
        (ok,) = spotter.call(abi.encodeWithSelector(0x1504460f, bytes32("BAL-A")));
        (ok,) = spotter.call(abi.encodeWithSelector(0x1504460f, bytes32("RENBTC-A")));
        (ok,) = spotter.call(abi.encodeWithSelector(0x1504460f, bytes32("UNI-A")));
        (ok,) = spotter.call(abi.encodeWithSelector(0x1504460f, bytes32("AAVE-A")));
        (ok,) = spotter.call(abi.encodeWithSelector(0x1504460f, bytes32("UNIV2DAIETH-A")));
        (ok,) = spotter.call(abi.encodeWithSelector(0x1504460f, bytes32("UNIV2WBTCETH-A")));
        (ok,) = spotter.call(abi.encodeWithSelector(0x1504460f, bytes32("UNIV2USDCETH-A")));
        (ok,) = spotter.call(abi.encodeWithSelector(0x1504460f, bytes32("UNIV2DAIUSDC-A")));
        (ok,) = spotter.call(abi.encodeWithSelector(0x1504460f, bytes32("UNIV2ETHUSDT-A")));
        (ok,) = spotter.call(abi.encodeWithSelector(0x1504460f, bytes32("UNIV2LINKETH-A")));
        (ok,) = spotter.call(abi.encodeWithSelector(0x1504460f, bytes32("UNIV2UNIETH-A")));
        (ok,) = spotter.call(abi.encodeWithSelector(0x1504460f, bytes32("UNIV2WBTCDAI-A")));
        (ok,) = spotter.call(abi.encodeWithSelector(0x1504460f, bytes32("UNIV2AAVEETH-A")));
        (ok,) = spotter.call(abi.encodeWithSelector(0x1504460f, bytes32("UNIV2DAIUSDT-A")));
        (ok,) = spotter.call(abi.encodeWithSelector(0x1504460f, bytes32("ETH-C")));
    }
}
