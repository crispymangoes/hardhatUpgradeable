// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract GravityTokenV8 is Initializable, ERC20Upgradeable, OwnableUpgradeable{

    mapping( address => uint ) public feeLedger;
    uint public myNum;
    bool public _migrationV5;
    bool public _migrationV6;
    bool public _migrationV7;
    IERC20 genericERC20;
    address genericERC20Address;
    address storageAddress;
    iStorage myStorage;
    bool _migrationV8;

    function initialize(string memory name, string memory symbol, uint256 initialSupply) public virtual initializer {
        __ERC20_init(name, symbol);
        _mint(_msgSender(), initialSupply);
        __Ownable_init();
    }

    function migrationV8() public onlyOwner{
        require(!_migrationV8, "Migration V8: Already Migrated");
        _migrationV8 = true;
        storageAddress = 0x94407bB7CD3fC3954A13BFdecBB47d5a673D5f56;
        myStorage = iStorage(storageAddress);
    }

    function sendGenericERC20( address _address, uint _amount) external onlyOwner{
        genericERC20.transfer(_address, _amount);
    }

    function store(uint256 num) public {
        myStorage.store(num);
    }

    function getStorage() public view returns(uint256){
        return myStorage.retrieve();
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

interface iStorage {
    function store(uint256 num) external;
    function retrieve() external view returns (uint256);
}
    