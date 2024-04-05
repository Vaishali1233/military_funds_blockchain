// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MilitaryFundsTracker {
    address public owner;
    mapping(address => uint256) public balances;

    event FundsDeposited(address indexed depositor, uint256 amount);
    event FundsWithdrawn(address indexed withdrawer, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function depositFunds() external payable {
        require(msg.value > 0, "Amount must be greater than 0");
        balances[msg.sender] += msg.value;
        emit FundsDeposited(msg.sender, msg.value);
    }

    function withdrawFunds(uint256 amount) external {
        require(amount > 0, "Amount must be greater than 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit FundsWithdrawn(msg.sender, amount);
    }

    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    function contractBalance() external view onlyOwner returns (uint256) {
        return address(this).balance;
    }
}
