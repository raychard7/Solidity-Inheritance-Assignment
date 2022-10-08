// SPDX-License-Identifier: MIT

pragma solidity 0.7.5;

//To iherit from a diff contract(ownable)

//1.import contract, 2. contractA is contractB{},3. add modifier from contract B to contract A function(withdraw)

import "./Ownable.sol";
import "./Destroyable.sol";
        
    
//Multiple inheritance start with most baselike(ownable), destroyable has prop of ownable.

contract Bank is Ownable, Destroyable{

    mapping(address => uint) balance;

    event depositDone(uint amount, address indexed depositedTo);

    function deposit() public payable returns (uint) {

       balance[msg.sender] += msg.value;

       emit depositDone( msg.value, msg.sender);//msg.value contains the amount of eth/wei sent in transaction.

       return balance[msg.sender];

    }

//onlyOwner doesn't exist in bank anymore has to be imported.
//How bank can inhertit Ownable contract.
//contract Bank is Ownable

    function withdraw(uint amount) public onlyOwner returns(uint){

        require(balance[msg.sender] >= amount);

        msg.sender.transfer(amount);

        return balance[msg.sender];

    }

 

    function getBalance() public view returns (uint) {

         return balance[msg.sender];

    }

 

    function transfer(address recipient, uint amount)  public {

        require(balance[msg.sender] >= amount, "Balance not sufficient");

        require(msg.sender != recipient, "Don't transfer money to yourself");

 

        uint previousSenderBalance = balance[msg.sender];

 

        _transfer(msg.sender, recipient, amount);

        assert(balance[msg.sender] == previousSenderBalance - amount);

    }

   

    function _transfer(address from, address to, uint amount) private{

        balance[from] -= amount;

        balance[to] += amount;

    }

 

}