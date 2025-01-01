const ExampleTransferFund = artifacts.require("ExampleTransferFund");

module.exports = function(deployer) {
  deployer.deploy(ExampleTransferFund);
};