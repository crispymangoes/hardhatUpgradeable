const { upgrades } = require("hardhat");

// scripts/upgrade.js
async function main() {
    const proxyAddress = '0xdCBbc3ED6987bA2DB53E138EA3E39Cd75b110247';
   
    const TokenV8 = await ethers.getContractFactory("GravityTokenV8");
    console.log("Preparing upgrade...");
    const tokenV8Address = await upgrades.prepareUpgrade(proxyAddress, TokenV8);
    console.log("GravityTokenV8 at:", tokenV8Address);
    const tokenV8 = await upgrades.upgradeProxy(proxyAddress, TokenV8);
    //How to properly call a migration function I think lol
    //const tokenContract = await TokenV6.attach(tokenV6.address) 
    //await tokenContract.migrationV6();

    console.log("Upgrade Successful!")
  }
   
  main()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error);
      process.exit(1);
    });