var HongContract = artifacts.require("HongERC20");

module.exports = function(deployer) {
    // deployment steps
    deployer.deploy(HongContract, "0xA5e458041D2D584123a2B55E2F8283a8b330cDB3");
};
