const MilitaryFundsTracker = artifacts.require("MilitaryFundsTracker");

module.exports = function(deployer) {
  deployer.deploy(MilitaryFundsTracker);
};
