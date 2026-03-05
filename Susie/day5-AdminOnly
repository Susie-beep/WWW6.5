//SPDX-License-Identifier: MIT
 pragma solidity ^0.8.0;

 contract AdminOnly {
    address public owner;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "Access denied: only the owner can perform this action ");
        _;
    }

    //owner add treasure

    uint public treasureAmount;

    function addTreasure(uint256 amount) public onlyOwner{
        treasureAmount +=amount;
    }

    //allow people get treasure
    mapping(address =>uint256) public withdrawAllowance;
    function approveWithdraw(address recipient, uint256 amount) public onlyOwner{
        require(amount<= treasureAmount, "Not enough treasure available");
        withdrawAllowance[recipient]= amount;
    }

    //get treasure
    mapping(address=>bool) public hasWithdrawn;
    function withdrawTreasure(uint256 amount) public {
        if (msg.sender == owner) {
            require(amount<=treasureAmount, "Not enough treasury available");
            treasureAmount -=amount;
            return;
        }
        uint allowance=withdrawAllowance[msg.sender];
        require(allowance>0, "You don't have any treasure allowance");
        require(!hasWithdrawn[msg.sender],"You have already withdrawn your treasure");
        require(allowance<=treasureAmount, "Not enough treasure in the chest");
        hasWithdrawn[msg.sender]= true;
        treasureAmount-=allowance;
        withdrawAllowance[msg.sender]=0;
    }
    //reset withdraw status
    function resetWithdrawStatus(address user) public onlyOwner{
            hasWithdrawn[user]=false;
        }
    //transfer ownership
    function transferOwnership(address newOwner) public onlyOwner {
            require(newOwner != address(0), "Invalid address");
            owner=newOwner;
        }
    function getTreasureDetails() public view onlyOwner returns (uint256) {
        return treasureAmount;
    }


 }
