// scripts/deploy.js
const deployLottery = async () => {
  const Lottery = await ethers.getContractFactory("Lottery");
  console.log("Deploying Lottery...");
  const lottery = await Lottery.deploy();
  await lottery.deployed();
  console.log("Lottery deployed to:", lottery.address);
}

const deployUpsideV1PoolFactory = async () => {
  console.log("UpsideV1PoolFactory: Initialize")
  const UpsideV1PoolFactory = await ethers.getContractFactory("UpsideV1PoolFactory");
  console.log("UpsideV1PoolFactory: Deploying")
  const upsideV1PoolFactory = await UpsideV1PoolFactory.deploy();
  await upsideV1PoolFactory.deployed();
  console.log("UpsideV1PoolFactory: Deployment Address --", upsideV1PoolFactory.address)
}

async function main() {
  // We get the contract to deploy
  await deployUpsideV1PoolFactory()
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
