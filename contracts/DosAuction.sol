// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Auction.sol";

contract DosAuction is Auction {
    address[] public allBidders;
    uint public refundProgress;

    function bid() external override payable {
        bidders[msg.sender] += msg.value;
        allBidders.push(msg.sender);
    }

    function refund() override external {
        for(uint i = refundProgress; i < allBidders.length; i++) {
            address bidder = allBidders[i];

            (bool success,) = bidder.call{value: bidders[bidder]}("");
            require(success, "failed!"); // unsafe

            refundProgress++;
        }
    }
}

