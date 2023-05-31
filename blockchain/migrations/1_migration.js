const Assets= artifacts.require("InvestorAssets");

module.exports = function(deployer) {
  deployer.deploy(Assets);
};
