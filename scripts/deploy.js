// scripts/deploy.js
const deployUpsideV1Factory = async () => {
  console.log("deployUpsideV1Factory: Initialize")
  const UpsideV1Factory = await ethers.getContractFactory("UpsideV1Factory");
  console.log("UpsideV1Factory: Deploying")
  const upsideV1Factory = await UpsideV1Factory.deploy();
  await upsideV1Factory.deployed();
  console.log("UpsideV1Factory: Deployed -- at address: ", upsideV1Factory.address)
}

async function main() {
  // We get the contract to deploy
  await deployUpsideV1Factory()
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
