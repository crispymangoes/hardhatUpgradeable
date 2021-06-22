const { upgrades } = require("hardhat");

// scripts/upgrade.js
async function main() {
    const proxyAddress = '0xC5D26fa3136ad13880De5D1b4a181f876D71b0cA';
   
    const BoxV2 = await ethers.getContractFactory("BoxV2");
    console.log("Preparing upgrade...");
    const boxV2Address = await upgrades.prepareUpgrade(proxyAddress, BoxV2);
    console.log("BoxV2 at:", boxV2Address);
    const boxV2 = await upgrades.upgradeProxy(proxyAddress, BoxV2);
    console.log("Upgrade Successful!")
  }
   
  main()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error);
      process.exit(1);
    });