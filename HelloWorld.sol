// SPDX-License-Identifier: MIT

pragma solidity 0.7.5;

//To iherit from a diff contract(ownable)

//1.import contract, 2. contractA is contractB{},3. add modifier from contract B to contract A function(withdraw)

import "./Ownable.sol";
import "./Destroyable.sol";
        
interface GovernmentInterface{
    
    function addTransaction(address _from, address _to, uint _amount) external; //need entire function header.
}

//Multiple inheritance start with most baselike(ownable), destroyable has prop of ownable.

contract Bank is Ownable, Destroyable{

                                            //creating instance of GovernmentInterface Ln:12
    GovernmentInterface GovernmentInstance = GovernmentInterface(0xDA0bab807633f07f013f94DD0E6A4F96F8742B53);

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

    //getOwner test fxn for './Ownable' => B4 private: address private owner ;After internal: address internal owner  ;
    // function getOwner () public view returns (address){
    //     return owner;
    // }

    function transfer(address recipient, uint amount)  public {
        require(balance[msg.sender] >= amount, "Balance not sufficient");

        require(msg.sender != recipient, "Don't transfer money to yourself");

        uint previousSenderBalance = balance[msg.sender];

        _transfer(msg.sender, recipient, amount);
    //Call to an external contract governmentInstace
        GovernmentInstance.addTransaction(msg.sender,recipient, amount);

        assert(balance[msg.sender] == previousSenderBalance - amount);

    }

   

    function _transfer(address from, address to, uint amount) private{

        balance[from] -= amount;

        balance[to] += amount;

    }

 

}