// SPDX-License-Identifier: MIT
pragma solidity 0.7.5;
//Government contract acts as an external contract.



contract Government {
    
    struct Transaction {
        address from;
        address to;
        uint amount;
        uint txId;
    }

    //array
    Transaction[] transactionLog;

    function addTransaction(address _from, address _to, uint _amount) external {
// Use "memory" for complex datatypes, stings, "structs"
// number data types "uint" don't need memory solidity already knows.
//transactionLog.length is the id or index of transaction.
        transactionLog.push(Transaction(_from, _to, _amount, transactionLog.length));
    }

//view because we're not changing anything in the state.
//can't return struct, so returns indiivual datatypes from struct(address, address, uint). 
    function getTransaction(uint _index) public view returns(address, address, uint) {
        return(transactionLog[_index].from, transactionLog[_index].to, transactionLog[_index].amount);
    }
}
//Timestamp government contract end: 10:36