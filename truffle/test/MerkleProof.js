const MerkleTree = artifacts.require("MerkleTree");

describe("MerkleTree", function () {
    it("should return true", async function () {
        const merkleTree = await MerkleTree.deployed();
        let account = "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4"
        let tokenId = 0
        let proof = ["0x999bf57501565dbd2fdcea36efa2b9aef8340a8901e3459f4a4c926275d36cdb", "0x4726e4102af77216b09ccd94f40daa10531c87c4d60bba7f3b3faf5ff9f19b3c"]
        await merkleTree.mint(account, tokenId, proof)
        console.log("Mint Success")
    });
});