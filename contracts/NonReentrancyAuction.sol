// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Auction.sol";

contract NonReentrancyAuction is Auction {
    bool internal locked;

    modifier noReentrancy() {
        require(!locked, "no reentrancy!");
        locked = true;
        _;
        locked = false;
    }
    // pull
    function refund() noReentrancy override external  {
        uint refundAmount = bidders[msg.sender];

        if (refundAmount > 0) {
            bidders[msg.sender] = 0;

            (bool success,) = msg.sender.call{value: refundAmount}("");

            require(success, "failed!");
        }
    }
}
