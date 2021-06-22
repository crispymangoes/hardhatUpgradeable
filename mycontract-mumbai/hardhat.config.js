// hardhat.config.js
const { alchemyApiKey, mnemonic } = require('./secrets.json');

require("@nomiclabs/hardhat-ethers");
require('@openzeppelin/hardhat-upgrades');

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.3",
  networks: {
    mumbai: {
      url: `https://rpc-mumbai.maticvigil.com/`,
      accounts: {mnemonic: mnemonic}
    }
  }
};