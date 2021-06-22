// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract GravityTokenV7 is Initializable, ERC20Upgradeable, OwnableUpgradeable{

    mapping( address => uint ) public feeLedger;
    uint public myNum;
    bool public _migrationV5;
    bool public _migrationV6;
    bool public _migrationV7;
    IERC20 genericERC20;
    address genericERC20Address;

    function initialize(string memory name, string memory symbol, uint256 initialSupply) public virtual initializer {
        __ERC20_init(name, symbol);
        _mint(_msgSender(), initialSupply);
        __Ownable_init();
    }

    function migrationV7(address _tokenAddress) public onlyOwner{
        require(!_migrationV7, "Migration V7: Already Migrated");
        _migrationV7 = true;
        genericERC20Address = _tokenAddress;
        genericERC20 = IERC20(genericERC20Address);
    }

    function sendGenericERC20( address _address, uint _amount) external onlyOwner{
        genericERC20.transfer(_address, _amount);
    }

    function sendContractTokens( address _address, uint _amount) external onlyOwner{
        transfer(_address, _amount);
    }

    function getAddress() external view returns(address){
        return address(this);
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
    