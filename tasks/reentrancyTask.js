const {task} = require("hardhat/config");

task("reentrancyTask", "Attack unsafe auction")
  .addParam("contract")
  .setAction(async (taskArgs) => {
    const main = require('../scripts/reentrancy');
    await main(taskArgs);
  });
