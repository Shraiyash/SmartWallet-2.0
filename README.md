Welcome to the Smart Wallet 2.0, a decentralized application (dApp) built using Solidity. This is version 2 of the basic smart wallet that demonstrates the functionality of a more secure, owner-driven wallet capable of receiving funds, managing transfers, and providing additional features such as transfer restrictions, ownership transfers, and voting mechanisms.

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Features
	
 1.	Single Ownership:
	•	The wallet has a single owner at any given time, ensuring centralized control over its core operations.
	
 2.	Receive Funds:
	•	The wallet can receive funds in the form of Ether from any external account or smart contract.
	
 3.	Transfer Funds:
	•	Funds can be transferred to:
	•	Externally Owned Accounts (EOAs)
	•	Other Smart Contracts
	•	Transfers are controlled and secured.
	
 4.	Restricted Transfer Amounts:
	•	Each party (recipient) has a maximum limit on the amount they can receive in a single transfer.
	
 5.	Ownership Transfer with Voting:
	•	Ownership can be transferred to a new owner, but only after approval from 3 out of 5 authorized voters.
	•	This feature ensures collective decision-making and prevents unilateral control over ownership changes.

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Contract Functions

1. Only Owner Functions
	•	constructor(): Initializes the contract with the deploying account as the owner.
	•	transferOwnership(address newOwner): Initiates ownership transfer; requires 3 votes from authorized voters.

2. Receiving Funds
	•	receive() external payable: Enables the wallet to accept Ether directly.

3. Transfer Funds
	•	transferFunds(address payable recipient, uint256 amount): Allows transferring Ether to a recipient (EOA or smart contract), adhering to transfer limits.

4. Restricted Amounts
	•	setTransferLimit(address recipient, uint256 limit): Sets a maximum transfer limit for a recipient (owner-only).

5. Voting for Ownership Transfer
	•	proposeNewOwner(address newOwner): Proposes a new owner; can be called by any authorized voter.
	•	voteForOwner(address proposedOwner): Casts a vote to approve the proposed ownership transfer.
	•	finalizeOwnershipTransfer(): Completes the ownership transfer if 3 out of 5 votes are reached.

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Setup and Deployment
	
 1.	Prerequisites:
	•	Install Node.js and npm.
	•	Install Truffle or Hardhat for smart contract development.
	•	Install Ganache or connect to a testnet (e.g., Rinkeby).
	
 2.	Clone the Repository:

git clone https://github.com/<your-repo>/smart-wallet.git
cd smart-wallet

 3.	Install dependencies

npm install

 4.	Compile Contracts

npx hardhat compile

 5.	Deploy Contracts

npx hardhat run scripts/deploy.js --network <network-name>
    
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Testing
	
 1.	Run tests to validate the functionality:

 npx hardhat test

 2. Use Remix for manual testing and interaction with the smart contract.
