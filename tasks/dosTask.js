const {task} = require("hardhat/config");

task("dosTask", "Attack dos auction")
  .addParam("contract")
  .setAction(async (taskArgs) => {
    const main = require('../scripts/dos');
    await main(taskArgs);
  });
