var HongContract = artifacts.require("HongERC20");

module.exports = function(deployer) {
    // deployment steps
    deployer.deploy(HongContract, "0x281AD57EdC50dD7d63C369FB18721FDA211D3C71");
};
