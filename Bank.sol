pragma solidity 0.7.5;

import "./Ownable.sol";
import "./Destroyable.sol";

contract Bank is Ownable, Destroyable{  
    mapping(address => uint) balance;
    
    function deposit () public payable returns (uint) {
        balance[msg.sender] += msg.value;
        return balance[msg.sender];
    }
    function withdraw (uint amount) public onlyOwner returns (uint) {
        require(balance[msg.sender] >= amount, "You dont have enough balance");
        msg.sender.transfer(amount);
        balance[msg.sender] -= amount;
        return balance[msg.sender];
    }
    function getBalance() public view returns (uint) {
        return balance[msg.sender];
    }
    function contractBalance() public view returns (uint) {
        return address(this).balance;
    }
    function transfer(address payable recipient, uint amount) public{
        require(balance[msg.sender] >= amount, "Don't have enough balance");
        require(recipient != msg.sender, "you are the sender & receiver");

        uint previousSenderBalance = balance[msg.sender];

        recipient.transfer(amount);

        assert(balance[msg.sender] == previousSenderBalance - amount);
    }
}
