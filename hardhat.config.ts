require('@nomicfoundation/hardhat-chai-matchers');

require('dotenv').config();

module.exports = {
  solidity: "0.8.9",
  networks: {
    goerli: {
      url: `${process.env.ALCHEMY_GOERLI_URL}`,
      accounts: [`0x${process.env.GOERLI_PRIVATE_KEY}`],
    } 
  }
};