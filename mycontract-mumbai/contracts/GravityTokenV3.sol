// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract GravityTokenV3 is Initializable, ERC20Upgradeable, OwnableUpgradeable{
    
    mapping( address => uint ) public feeLedger;
    function initialize(string memory name, string memory symbol, uint256 initialSupply) public virtual initializer {
        __ERC20_init(name, symbol);
        _mint(_msgSender(), initialSupply);
        __Ownable_init();
    }
    function mint(uint _amount) external onlyOwner {
        _mint(_msgSender(), _amount);
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        feeLedger[msg.sender] = 100;
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

}