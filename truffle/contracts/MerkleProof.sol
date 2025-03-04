// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";


library MerkleProof {
    function verify(
        bytes32[] memory proof,
        bytes32 root,
        bytes32 leaf
    ) internal pure returns (bool){
        return processProof(proof, leaf) == root;
    }

    function processProof(bytes32[] memory proof, bytes32 leaf) internal pure returns (bytes32) {
        bytes32 computeHash = leaf;
        for (uint256 i = 0; i < proof.length; i++) {
            computeHash = _hashPair(computeHash, proof[i]);
        }
        return computeHash;
    }

    function _hashPair(bytes32 a, bytes32 b) internal pure returns (bytes32)   {
        return a < b ? keccak256(abi.encodePacked(a, b)) : keccak256(abi.encodePacked(b, a));
    }
}

contract MerkleTree is ERC721 {
    // Merkle树的根
    bytes32 immutable public root;

    mapping(address => bool) public mintedAddress;

    // 构造函数，初始化NFT合集的名称、代号、Merkle树的根
    constructor(string memory _name, string memory _symbol, bytes32 merkleRoot) ERC721(_name, _symbol){
        root = merkleRoot;
    }

    function mint(address account, uint256 tokenId, bytes32[] calldata proof) external {
        require(_verify(_leaf(account), proof), "Invalid merkle proof");
        require(!mintedAddress[account], "Already minted!");
        mintedAddress[account] = true;
        _mint(account, tokenId);
    }


    function _leaf(address account) internal pure returns (bytes32)  {
        return keccak256(abi.encodePacked(account));
    }

    function _verify(bytes32 leaf, bytes32[] memory proof) internal view returns (bool)  {
        return MerkleProof.verify(proof, root, leaf);
    }
}


