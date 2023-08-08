// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

abstract contract Auction {
    mapping(address => uint) public bidders;

    function bid() external virtual payable {
        bidders[msg.sender] += msg.value;
    }

    function refund() virtual external;

    function currentBalance() external view returns(uint) {
        return address(this).balance;
    }

}
