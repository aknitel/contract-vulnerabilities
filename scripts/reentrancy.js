const hre = require('hardhat');
const ethers = hre.ethers;

module.exports = async function main(args) {
  const [bidder1, bidder2, hacker] = await ethers.getSigners();

  const AuctionFactory = await ethers.getContractFactory(args['contract'], bidder1);
  const auction = await AuctionFactory.deploy();
  await auction.waitForDeployment();

  const ReentrancyAttackerFactory = await ethers.getContractFactory("ReentrancyAttacker", hacker);
  const attacker = await ReentrancyAttackerFactory.deploy(auction.getAddress());
  await attacker.waitForDeployment();

  const txBid = await auction.bid({value: ethers.parseEther('4')});
  await txBid.wait();

  const txBid2 = await auction.connect(bidder2).bid({value: ethers.parseEther('8')});
  await txBid2.wait();

  const txBid3 = await attacker.connect(hacker).proxyBid({value: ethers.parseEther('1')});
  await txBid3.wait();

  console.log("Auction balance before attack", await ethers.provider.getBalance(auction.getAddress()));

  try {
    const doAttack = await attacker.connect(hacker).attack();
    await doAttack.wait();
  } catch (e) {
    console.log(e.message);
    console.log('Something went wrong while trying to attack');
  } finally {
    console.log("Auction balance after attack", await ethers.provider.getBalance(auction.getAddress()));
    console.log("Attacker balance after attack", await ethers.provider.getBalance(attacker.getAddress()));
  }
}
