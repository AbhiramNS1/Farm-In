const Store = artifacts.require("Storage");

module.exports = function(deployer) {
  deployer.deploy(Store);
};
