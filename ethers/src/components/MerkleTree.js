import {ethers} from "ethers";


async function main() {
    const provider = new ethers.JsonRpcProvider("http://127.0.0.1:8545")
    const signer = new ethers.Wallet("0xabd43d861f85a8464aebb7db22043a978ce204f4bc0b2c1c34ebad846eb31ee9", provider);
    const abi = [
        "function mint(address account, uint256 tokenId, bytes32[] calldata proof)",
        "function ownerOf(uint256 tokenId) public view returns (address)",
        "function balanceOf(address owner) public view returns (uint256)"
    ]
    const contract = new ethers.Contract("0xf8Ab13147Ba89dd9dEcdF724cF020797aB7d2e1E", abi, signer);
    let account = "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4"
    let tokenId = 0
    let proof = ["0x999bf57501565dbd2fdcea36efa2b9aef8340a8901e3459f4a4c926275d36cdb", "0x4726e4102af77216b09ccd94f40daa10531c87c4d60bba7f3b3faf5ff9f19b3c"]
    // 铸造
    await contract.mint(account, tokenId, proof)

    console.log(`Owner Address: ${await contract.ownerOf(0)}`)

    console.log(`Owner balanceOf: ${await contract.balanceOf(account)}`)

}

main()