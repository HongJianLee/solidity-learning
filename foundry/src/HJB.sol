// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {ERC1363} from "../dependencies/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC1363.sol";
import "../dependencies/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "../dependencies/openzeppelin-contracts/contracts/utils/Nonces.sol";
import "../dependencies/openzeppelin-contracts/contracts/access/Ownable.sol";
import "../dependencies/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "../dependencies/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "../dependencies/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "../dependencies/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Votes.sol";
import "../dependencies/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20FlashMint.sol";

contract HJB is ERC20, ERC20Burnable, ERC20Pausable, Ownable, ERC1363, ERC20Permit, ERC20Votes, ERC20FlashMint {
    constructor(address recipient, address initialOwner)
    ERC20("HJB", "HJ")
    Ownable(initialOwner)
    ERC20Permit("HJB")
    {
        _mint(recipient, 100 * 10 ** decimals());
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // The following functions are overrides required by Solidity.

    function _update(address from, address to, uint256 value)
    internal
    override(ERC20, ERC20Pausable, ERC20Votes)
    {
        super._update(from, to, value);
    }

    function nonces(address owner)
    public
    view
    override(ERC20Permit, Nonces)
    returns (uint256)
    {
        return super.nonces(owner);
    }
}
