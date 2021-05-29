import { ethers, waffle } from "hardhat";
import { UpsideV1Factory } from "../typechain/UpsideV1Factory";
import { expect } from "./shared/expect";
import { FeeAmount, getCreate2Address } from "./shared/utilities";

const { constants } = ethers;

const createFixtureLoader = waffle.createFixtureLoader;

describe("UpsideV1Factory", () => {
  const [wallet, other] = waffle.provider.getWallets();

  let factory: UpsideV1Factory;
  let poolBytecode: string;

  const fixture = async () => {
    const factoryFactory = await ethers.getContractFactory("UpsideV1Factory");
    return (await factoryFactory.deploy()) as UpsideV1Factory;
  };

  let loadFixture: ReturnType<typeof createFixtureLoader>;
  before("create fixture loader", async () => {
    loadFixture = createFixtureLoader([wallet, other]);
  });

  before("load pool bytecode", async () => {
    poolBytecode = (await ethers.getContractFactory("UpsideV1Factory"))
      .bytecode;
  });

  beforeEach("deploy factory", async () => {
    factory = await loadFixture(fixture);
  });

  it("owner is deployer", async () => {
    expect(await factory.owner()).to.eq(wallet.address);
  });
});
