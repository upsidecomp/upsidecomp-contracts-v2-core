// scripts/deploy.js
// const deployUpsideV1PoolFactory = async () => {
//   console.log("UpsideV1PoolFactory: Initialize")
//   const UpsideV1PoolFactory = await ethers.getContractFactory("UpsideV1PoolFactory");
//   console.log("UpsideV1PoolFactory: Deploying")
//   const upsideV1PoolFactory = await UpsideV1PoolFactory.deploy();
//   await upsideV1PoolFactory.deployed();
//   console.log("UpsideV1PoolFactory: Deployment Address --", upsideV1PoolFactory.address)
// }

const deployUpsideV1PoolDeployer = async () => {
  console.log("UpsideV1PoolDeployer: Initialize")
  const UpsideV1PoolDeployer = await ethers.getContractFactory("UpsideV1PoolDeployer");
  console.log("UpsideV1PoolDeployer: Deploying")
  const upsideV1PoolDeployer = await UpsideV1PoolDeployer.deploy();
  await upsideV1PoolDeployer.deployed();
  console.log("UpsideV1PoolFactory: Deployment Address --", upsideV1PoolDeployer.address)
}

async function main() {
  // We get the contract to deploy
  await deployUpsideV1PoolDeployer()
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
