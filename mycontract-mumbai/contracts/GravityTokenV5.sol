// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract GravityTokenV5 is Initializable, ERC20Upgradeable, OwnableUpgradeable{

    mapping( address => uint ) public feeLedger;
    uint public myNum;
    bool public _migrationV5;
    function initialize(string memory name, string memory symbol, uint256 initialSupply) public virtual initializer {
        __ERC20_init(name, symbol);
        _mint(_msgSender(), initialSupply);
        __Ownable_init();
    }

    function migrationV5() public onlyOwner{
        require(!_migrationV5, "Migration V5: Already Migrated");
        _migrationV5 = true;
        myNum = 7777;
    }

    function getNum() external view returns(uint){
        return myNum;
    }

    function mint(uint _amount) external onlyOwner {
        _mint(_msgSender(), _amount);
    }

    function getFees() public view returns(uint) {
        return feeLedger[msg.sender];
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        feeLedger[msg.sender] = 100;
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

}
    