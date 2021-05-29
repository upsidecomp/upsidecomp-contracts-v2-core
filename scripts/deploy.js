// scripts/deploy.js

const createPool = async (_instanceUpsideV1Factory, _owner, _fee) => {
  const owner = _owner;
  const fee = _fee;
  const instanceUpsideV1Factory = _instanceUpsideV1Factory;

  console.log("UpsideV1Factory: Creating Pool -- with owner: ", owner);
  await instanceUpsideV1Factory.createPool(owner, fee);
  const poolAddress = await instanceUpsideV1Factory.getPool(owner);
  console.log("UpsideV1Pool: Created -- at address: ", poolAddress);

  const UpsideV1Pool = await ethers.getContractFactory("UpsideV1Pool");
  const instanceUpsideV1Pool = await UpsideV1Pool.attach(poolAddress);
  console.log("Owner: ", await instanceUpsideV1Pool.owner());
  console.log("Factory: ", await instanceUpsideV1Pool.factory());
  console.log("Fee: ", await instanceUpsideV1Pool.fee());
};

async function main() {
  console.log("deployUpsideV1Factory: Initialize");
  const UpsideV1Factory = await ethers.getContractFactory("UpsideV1Factory");
  console.log("UpsideV1Factory: Deploying");
  const upsideV1Factory = await UpsideV1Factory.deploy();
  await upsideV1Factory.deployed();
  console.log(
    "UpsideV1Factory: Deployed -- at address: ",
    upsideV1Factory.address
  );

  const instanceUpsideV1Factory = await UpsideV1Factory.attach(
    upsideV1Factory.address
  );

  const accounts = await ethers.provider.listAccounts();
  const fee = 10;

  await createPool(instanceUpsideV1Factory, accounts[0], fee);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
