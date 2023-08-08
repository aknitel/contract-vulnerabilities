// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Auction.sol";

contract ReentrancyAuction is Auction {

    function refund() override external  {
        uint refundAmount = bidders[msg.sender];

        if (refundAmount > 0) {

            (bool success,) = msg.sender.call{value: refundAmount}("");
            require(success, "failed!");

            bidders[msg.sender] = 0; // unsafe
        }
    }
}
