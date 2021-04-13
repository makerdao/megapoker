// SPDX-License-Identifier: AGPL-3.0
// The RegaPoker
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

interface IlkReg {
    function list() external returns (bytes32[] memory);
    function pip(bytes32) external returns (address);
}

interface Chainlog {
    function getAddress(bytes32) external returns (address);
}

interface OSMLike {
    function src() external returns (address);
}

contract OmegaPoker {

    bytes4   constant ssel = 0x1504460f;  // "poke(bytes32)"
    bytes4   constant osel = 0x18178358;  // "poke()"

    Chainlog constant  cl = Chainlog(0xdA0Ab1e0017DEbCd72Be8599041a2aa3bA7e740F);
    address  immutable spot;
    IlkReg   immutable ir;

    bytes32[] public ilks;
    address[] public osms;

    constructor() public {
        ir = IlkReg(cl.getAddress("ILK_REGISTRY"));
        spot = cl.getAddress("MCD_SPOT");
    }

    function count() external view returns (uint256) {
        return ilks.length;
    }

    function bytesToAddress(bytes memory bys) private pure returns (address addr) {
        assembly {
          addr := mload(add(bys,20))
        }
    }

    function refresh() external {
        delete osms;
        delete ilks;
        bytes32[] memory _ilks = ir.list();
        for (uint256 i = 0; i < _ilks.length; i++) {
            address _pip = ir.pip(_ilks[i]);
            (bool ok, bytes memory val) = _pip.call(abi.encodeWithSignature("src()"));
            if (ok && bytesToAddress(val) != address(0)) {
                osms.push(_pip);
                ilks.push(_ilks[i]);
            }
        }
    }

    function poke() external {
        bytes32[] memory _ilks = ilks;
        address[] memory _osms = osms;
        bool _ok;
        for (uint256 i = 0; i < _ilks.length; i++) {
            (_ok,) = _osms[i].call(abi.encodeWithSelector(osel));
            (_ok,) = spot.call(abi.encodeWithSelector(ssel, _ilks[i]));
        }
    }
}
