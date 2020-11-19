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

pragma solidity ^0.6.7;

interface OsmLike {
    function poke() external;
    function pass() external view returns (bool);
}

interface SpotLike {
    function poke(bytes32) external;
}

interface IlkRegistryAbstract {
    function ilks() external view returns (bytes32[] memory);
}

interface ChainlogAbstract {
    function getAddress(bytes32) external view returns (address);
    function count() external view returns (uint256);
}

contract MegaPoker {

    event Debug(string);

    ChainlogAbstract public constant log = ChainlogAbstract(0xdA0Ab1e0017DEbCd72Be8599041a2aa3bA7e740F);

    function process() internal {
        uint count = ChainlogAbstract(0xdA0Ab1e0017DEbCd72Be8599041a2aa3bA7e740F).count();
        // address bleh = address(log);
        // bytes32[] memory ilks = IlkRegistryAbstract(log.getAddress("ILK_REGISTRY")).ilks();

        // OsmLike osm;
        string memory pip = "PIP_";
        // emit Debug(pip);
        

        // for(uint i = 0; i < ilks.length; i += 1) {
            // emit Debug(pip.concat(string(ilks[i])));
            // log.getAddress(pip.concat(string(ilks[i])))
            // osm = OsmLike(0x81FE72B5A8d1A857d176C3E7d5Bd2679A9B85763);
        // }
    }

    


    function poke() external {
        process();
    }

    // Use for poking OSMs prior to collateral being added
    function pokeTemp() external {
        process();
    }
}
