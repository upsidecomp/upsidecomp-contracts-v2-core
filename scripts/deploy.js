// scripts/deploy.js

async function main() {
  console.log("deployUpsideV1Factory: Initialize")
  const UpsideV1Factory = await ethers.getContractFactory("UpsideV1Factory");
  console.log("UpsideV1Factory: Deploying")
  const upsideV1Factory = await UpsideV1Factory.deploy();
  await upsideV1Factory.deployed();
  console.log("UpsideV1Factory: Deployed -- at address: ", upsideV1Factory.address);

  upsideV1Factory.createPool()
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
