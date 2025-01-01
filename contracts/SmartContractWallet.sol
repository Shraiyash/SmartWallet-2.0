// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

/*
Functions within the Smart Contract Wallet:

1 - There can only be one owner of the wallet
2 - Recieve funds 
3 - Transfer funds to EOE(Externally Owned Accounts) and other Smart Contracts
4 - Restricted amount that can be transfered for each party
5 - Option to transfer ownership with a vote of 3 out of 5 authorized members/voters

*/

contract ExampleTransferFund {

    uint counter;
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function deposit() public payable {
        counter++;
     }

    receive() external payable { }
}

contract SmarContracttWallet {

    address payable public owner;

    mapping(address => uint) public limits;
    mapping(address => bool) public AbletoSend;

    mapping(address => bool) authorizedVoters;

    address payable nextOwner;
    uint VoterCount;
    uint constant votesNeeded = 3;
    mapping(address => mapping(address => bool)) hasVoterAlrVoted;

    constructor() {
        owner = payable(msg.sender);
    }

    address[] public listofVoters;

    function assignVoter(address _voter) public {
        require(msg.sender == owner, "You are not authorized for this action");

        authorizedVoters[_voter] = true;

        listofVoters.push(_voter);
    }

    function getVoterList() public view returns (address[] memory) {
        return listofVoters;
    }

    function voteForNewOwner(address payable _newOwner) public {
        require(authorizedVoters[msg.sender], "You are not authorized for this action");

        // this makes sure the same voter doesn't vote twice for the specific newOwner
        require(hasVoterAlrVoted[_newOwner][msg.sender] == false, "You have already voted");

        if(nextOwner != _newOwner){
            nextOwner = _newOwner;
            VoterCount = 0;
        }

        VoterCount++;
        hasVoterAlrVoted[_newOwner][msg.sender] = true;

        if(VoterCount >= votesNeeded){
            owner = _newOwner;
            nextOwner = payable(address(0));
        }

    }

    // The limits are set for other parties by the owner through this function
    function setLimit(address _whoCanSend, uint _restriction) public {
        require(msg.sender == owner, "You are not authorized for this action");

        // set limit
        limits[_whoCanSend] = _restriction;

        if(_restriction > 0){
            AbletoSend[_whoCanSend] = true;
        }
        else {
            AbletoSend[_whoCanSend] = false;
        }
        
        
    }

    // Funds Transfering
    function transferFunds(address payable _to, uint amountToTransfer) public payable {
        //require(msg.sender == owner, "This action is restricted to the owner");

       // If it's not the owner, then limits apply
        if(msg.sender != owner){

            // checks for limits
            require(limits[msg.sender] >= amountToTransfer, "Transfer Limit Exceeded");

            //ensures no one's transfering unneccessary 0 currency repeatdly
            require(AbletoSend[msg.sender], "Transfer Amount Unacceptable");

            limits[msg.sender] -= amountToTransfer;

        }

        // The owner has no limit to transfer funds
        // (bool success, bytes memory returnData) =  _to.call{value: amountToTransfer}(_payload);
        // require(success, "Failed");
        // return returnData;

        _to.transfer(amountToTransfer);
    }

    receive() external payable { }


}