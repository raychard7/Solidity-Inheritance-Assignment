// SPDX-License-Identifier: MIT

pragma solidity 0.7.5;

contract Ownable{
    address private owner  ;

    modifier onlyOwner{
        require(msg.sender == owner);
        _; // run function
    }

   constructor(){
        owner= msg.sender;
    }
}
// a tiny function placed to run before the main function code.
// If you have a piece of code that is going to be used alot for different fxns.
// require(msg.sender == owner), is called with modifier onlyOwner
//add onlyOwner to fxn after visibility.
   
