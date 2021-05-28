// scripts/deploy.js
const deployLottery = () => {
  const Lottery = await ethers.getContractFactory("Lottery");
  console.log("Deploying Lottery...");
  const lottery = await Lottery.deploy();
  await lottery.deployed();
  console.log("Lottery deployed to:", lottery.address);
}

const deployUpsideV1PoolFactory = () => {
  const UpsideV1PoolFactory = await ethers.getContractFactory("UpsideV1PoolFactory");
  console.log("Deploying UpsideV1PoolFactory")
  const upsideV1PoolFactory = await UpsideV1PoolFactory.deploy();
  await upsideV1PoolFactory.deployed();
  console.log("UpsideV1PoolFactory deployed to:", upsideV1PoolFactory.address)
}

async function main() {
  // We get the contract to deploy
  deployUpsideV1PoolFactory()
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
