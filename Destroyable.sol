// SPDX-License-Identifier: MIT
import "./Ownable.sol";
pragma solidity 0.7.5;

//Allow any contractcontract inheriting from it to self destruct.
//This action should only be available for contract owner.
//keep contract owner functionality seperate in Ownable


contract Destroyable is Ownable {

    function destroyable() external onlyOwner  {

        //self destruct takes in 1 input, an addy to send all ether in contract.
        //Address(msg.sender) must be payable to work because it has to be capable of accepting eth.
        selfdestruct(payable(msg.sender)); 

    }

}