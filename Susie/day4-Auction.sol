// SPDX - License-Identifier: MIT
pragma solidity^0.8.0;
contract Auction{
    address public owner;
    string public item;
    uint public auctionEndTime;
    address private highestBidder;
    uint private highestBid;
    bool public ended;
    mapping(address => uint) public bids;
    address[] public bidders;

    constructor(string memory _item, uint _biddingTime) {
        owner = msg.sender;
        item = _item;
        auctionEndTime = block.timestamp+ _biddingTime;

    }
    //ask
    function bid() external payable{
        require(block.timestamp < auctionEndTime, "Action has already ended.");
        uint amount = msg.value;
        require(amount >0, "Bid amount must be greater than 0.");
        require(amount>bids[msg.sender], "New bid must be higher than your current bid.");
        //Minimum incremental rule
        require(amount*100>=highestBid*105, "Bid must be at least 5% higher than current highest bid.");

        if (bids[msg.sender]==0) {
            bidders.push(msg.sender);
        }
        //refund previous bid if exists
        if (bids[msg.sender]>0) {
     
            payable(msg.sender).transfer(bids[msg.sender]);
           
        }
        //update sender bid information
        bids[msg.sender] = amount;
        //update highest bid
        if(amount>highestBid) {
            highestBid = amount;
            highestBidder = msg.sender;
        }
    }

    function endAuction() external {
        require(block.timestamp>= auctionEndTime, "Auction hasn't ended yet");
        require(!ended, "Auction end already called.");
        ended =true;
    }
    
    //allow unsuccessful bidders to withdraw their bids  
    function withdrawBid() external {
    //省略一堆require
    
    uint amount = bids[msg.sender];
    require(amount>0,"No balance");
    bids[msg.sender] = 0;
    payable(msg.sender).transfer(amount);
    }
    //check winner
    function getWinner() external view returns (address,uint) {
        require(ended, "Auction has not ended yet.");
        return (highestBidder, highestBid);
    }
    
    //view all binnders
    function getAllBidders() external view returns (address[] memory) {
        return bidders;
    }
}


