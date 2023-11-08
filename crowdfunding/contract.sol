// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Crowdfunding {
    bytes32 internal constant FUNDINGNAMESPACE = keccak256('funding.facet');
    function fundingStorage() internal pure returns( fundingdata storage s) {
        bytes32 position = FUNDINGNAMESPACE;
        assembly {
            s.slot := position
        }
    }

    struct fundingdata{

    address  owner;
    uint256  goal;
    uint256  deadline;
    bool  fundingGoalReached;
    bool  campaignEnded;
    
    mapping(address => uint256)  contributions;
    uint256  totalContributions;
    }

    event FundTransfer(address contributor, uint256 amount, bool isContribution);
    event Refund(address contributor, uint256 amount);

    function initializewalletdata(uint256 _goalInEther, uint256 _durationInMinutes) public {
        fundingdata storage s = fundingStorage();
        s.owner=msg.sender;
        s.goal = _goalInEther * 1 ether;
        s.deadline =  _durationInMinutes ;
    }
   
    modifier onlyOwner() {
        fundingdata storage s = fundingStorage();
        require(msg.sender == s.owner, "Only the owner can call this function");
        _;
    }

    modifier onlyContributor() {
        fundingdata storage s = fundingStorage();
        require(s.contributions[msg.sender] > 0, "Only contributors can call this function");
        _;
    }

    function contribute() public payable {
        fundingdata storage s = fundingStorage();
        require(!s.campaignEnded, "Campaign has ended");
        require(block.timestamp < s.deadline, "Campaign deadline reached");
        s.contributions[msg.sender] += msg.value;
        s.totalContributions += msg.value;
        emit FundTransfer(msg.sender, msg.value, true);
    }

    function checkGoalReached() public onlyOwner {
        fundingdata storage s = fundingStorage();
        require(!s.campaignEnded, "Campaign has already ended");
        require(block.timestamp >= s.deadline, "Campaign deadline not reached yet");
        
        if (s.totalContributions >= s.goal) {
            s.fundingGoalReached = true;
        }
        s.campaignEnded = true;
    }

    function withdrawFunds() public onlyOwner {
        fundingdata storage s = fundingStorage();
        require(s.campaignEnded, "Campaign must have ended");
        require(s.fundingGoalReached, "Funding goal not reached");
        payable(s.owner).transfer(s.totalContributions);
        emit FundTransfer(s.owner, s.totalContributions, false);
    }

    function refundContribution() public onlyContributor {
        fundingdata storage s = fundingStorage();
        require(s.campaignEnded, "Campaign must have ended");
        require(!s.fundingGoalReached, "Funding goal reached");
        uint256 amount = s.contributions[msg.sender];
        s.contributions[msg.sender] = 0;
        s.totalContributions -= amount;
        payable(msg.sender).transfer(amount);
        emit Refund(msg.sender, amount);
    }
}
