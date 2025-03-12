// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {IERC721Receiver} from "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract NFTSwap is IERC721Receiver {
    event List(
        address indexed seller,
        address indexed nftAddr,
        uint256 indexed tokenId,
        uint256 price
    );

    event Purchase(
        address indexed buyer,
        address indexed nftAddr,
        uint256 indexed tokenId,
        uint256 price
    );

    event Revoke(
        address indexed seller,
        address indexed nftAddr,
        uint256 indexed tokenId
    );

    event Upate(
        address indexed seller,
        address indexed nftAddr,
        uint256 indexed tokenId,
        uint256 newPrice
    );

    struct Order {
        address owner;
        uint256 price;
    }

    mapping(address => mapping(uint256 => Order)) public nftList;

    receive() external payable {}

    fallback() external payable {}

    function list(
        address _nftAddr,
        uint256 _tokenId,
        uint256 _price
    ) public {
        IERC721 _nft = IERC721(_nftAddr);
        require(_nft.getApproved(_tokenId) == address(this));
        require(_price > 0);
        Order storage order = nftList[_nftAddr][_tokenId];
        order.owner = msg.sender;
        order.price = _price;

        _nft.safeTransferFrom(msg.sender, address(this), _tokenId);

        emit List(msg.sender, _nftAddr, _tokenId, _price);
    }

    function revoke(address _nftAddr, uint256 _tokenId) public {
        Order storage order = nftList[_nftAddr][_tokenId];
        require(msg.sender == order.owner);
        IERC721 _nft = IERC721(_nftAddr);
        require(_nft.ownerOf(_tokenId) == address(this));
        _nft.safeTransferFrom(address(this), msg.sender, _tokenId);

        delete nftList[_nftAddr][_tokenId];
        emit Revoke(msg.sender, _nftAddr, _tokenId);
    }

    function update(
        address _nftAddr,
        uint256 _tokenId,
        uint256 _newPrice
    ) public {
        Order storage order = nftList[_nftAddr][_tokenId];
        require(order.owner == msg.sender);
        IERC721 _nft = IERC721(_nftAddr);
        require(_nft.ownerOf(_tokenId) == address(this));
        order.price = _newPrice;

        emit Upate(msg.sender, _nftAddr, _tokenId, _newPrice);
    }

    function purchase(address _nftAddr, uint256 _tokenId) public payable {
        Order storage order = nftList[_nftAddr][_tokenId];
        require(order.price > 0);
        require(msg.value >= order.price);
        IERC721 _nft = IERC721(_nftAddr);
        require(_nft.ownerOf(_tokenId) == address(this));

        _nft.transferFrom(address(this), msg.sender, _tokenId);
        payable(order.owner).transfer(order.price);
        if (msg.value > order.price) {
            payable(msg.sender).transfer(msg.value - order.price);
        }

        emit Purchase(msg.sender, _nftAddr, _tokenId, order.price);
        delete nftList[_nftAddr][_tokenId];
    }

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external pure override returns (bytes4) {
        return IERC721Receiver.onERC721Received.selector;
    }
}
