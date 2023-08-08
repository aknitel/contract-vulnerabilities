require("@nomicfoundation/hardhat-toolbox");
require('./tasks/reentrancyTask');
require('./tasks/dosTask');

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.19"
};
