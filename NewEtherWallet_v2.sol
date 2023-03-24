// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

/* Project : Implementation of ether wallet.
1. Anyone can send ethers into this wallet.
2. But only owner can send ethers out of this wallet.*/

contract NewEtherWallet{

    address payable public owner;
    address payable internal receiver;

    constructor(){
        owner = payable(msg.sender);
    }

    //Enables the contract to receive ether
    receive () external payable {}

    function withdraw (uint _amount) external {
        require(msg.sender == owner, "You are not authorised to do this transaction");
        
        // Transfer ethers from contract to owner
        //owner.transfer(_amount);
        
        // To save gas, we will replace state variable "owner" with memory variable "msg.sender"
        payable(msg.sender).transfer(_amount);

        // These lines of code also do the same transfer activity as above
        //(bool sent,) = msg.sender.call{value: _amount}("");
        //require (sent, "Failed to transfer ether");
    }

    function addReceiver (address payable _receiver) external {
        require(msg.sender == owner, "You are not authorised to do this transaction");
        require(_receiver != address(0), "Enter receiver address to send money");

        receiver = _receiver;

    }
    
    function send (uint _amount) external {
        require(msg.sender == owner, "You are not authorised to do this transaction");
    
        payable(receiver).transfer(_amount);
    }

    function getBalance() external view returns (uint){
        return (address(this).balance);

    }

    

}