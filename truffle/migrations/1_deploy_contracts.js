var contract = artifacts.require("MerkleTree");

module.exports = function(deployer) {
    // deployment steps
    deployer.deploy(contract, "HongJian", "LI", "0xeeefd63003e0e702cb41cd0043015a6e26ddb38073cc6ffeb0ba3e808ba8c097");
};
