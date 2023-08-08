// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Auction.sol";

contract NonDosAuction is Auction {
    address[] public allBidders;
    uint public refundProgress;
    address[] public failedRefundBidders;

    function bid() external override payable {
        bidders[msg.sender] += msg.value;
        allBidders.push(msg.sender);
    }

    function refund() override external {
        for(uint i = refundProgress; i < allBidders.length; i++) {
            address bidder = allBidders[i];

            (bool success,) = bidder.call{value: bidders[bidder]}("");
            if(!success) {
                failedRefundBidders.push(bidder);
            }

            refundProgress++;
        }
    }
}

