import { ethers, waffle } from 'hardhat'
import { UpsideV1Factory } from '../typechain/UpsideV1Factory'
import { expect } from './shared/expect'
import snapshotGasCost from './shared/snapshotGasCost'

import { FeeAmount, getCreate2Address } from './shared/utilities'

const { constants } = ethers

const createFixtureLoader = waffle.createFixtureLoader

const POOL_OWNER = '0x1000000000000000000000000000000000000000'

describe('UpsideV1Factory', () => {
  const [wallet, other] = waffle.provider.getWallets()

  let factory: UpsideV1Factory
  let poolBytecode: string

  const fixture = async () => {
    const factoryFactory = await ethers.getContractFactory('UpsideV1Factory')
    return (await factoryFactory.deploy()) as UpsideV1Factory
  }

  let loadFixture: ReturnType<typeof createFixtureLoader>
  before('create fixture loader', async () => {
    loadFixture = createFixtureLoader([wallet, other])
  })

  before('load pool bytecode', async () => {
    poolBytecode = (await ethers.getContractFactory('UpsideV1Pool')).bytecode
  })

  beforeEach('deploy factory', async () => {
    factory = await loadFixture(fixture)
  })

  it('owner is deployer', async () => {
    expect(await factory.owner()).to.eq(wallet.address)
  })

  it('factory bytecode size', async () => {
    expect(((await waffle.provider.getCode(factory.address)).length - 2) / 2).to.matchSnapshot()
  })

  it('pool bytecode size', async () => {
    await factory.createPool(FeeAmount.MEDIUM)
    const poolAddress = getCreate2Address(factory.address, FeeAmount.MEDIUM, poolBytecode)
    expect(((await waffle.provider.getCode(poolAddress)).length - 2) / 2).to.matchSnapshot()
  })

  async function createAndCheckPool(feeAmount: FeeAmount) {
    const create2Address = getCreate2Address(factory.address, feeAmount, poolBytecode)

    const create = factory.createPool(feeAmount)
    const poolContractFactory = await ethers.getContractFactory('UpsideV1Pool')
    const pool = poolContractFactory.attach(create2Address)

    await expect(create).to.emit(factory, 'PoolCreated').withArgs(feeAmount, create2Address)
    await expect(factory.createPool(feeAmount)).to.be.reverted
    expect(await factory.pool(), 'pool').to.eq(create2Address)
    expect(await pool.factory(), 'pool factory address').to.eq(factory.address)
    expect(await pool.feePercentage(), 'pool fee').to.eq(feeAmount)
  }

  describe('#createPool', () => {
    it('succeeds for low fee pool', async () => {
      await createAndCheckPool(FeeAmount.LOW)
    })

    it('succeeds for medium fee pool', async () => {
      await createAndCheckPool(FeeAmount.MEDIUM)
    })
    it('succeeds for high fee pool', async () => {
      await createAndCheckPool(FeeAmount.HIGH)
    })

    // todo: fix
    // it("fails if fee amount is not enabled", async () => {
    //   await expect(factory.createPool(POOL_OWNER, 250)).to.be.reverted;
    // });

    it('gas', async () => {
      await snapshotGasCost(factory.createPool(FeeAmount.MEDIUM))
    })
  })

  describe('#setOwner', () => {
    it('fails if caller is not owner', async () => {
      await expect(factory.connect(other).setOwner(wallet.address)).to.be.reverted
    })

    it('updates owner', async () => {
      await factory.setOwner(other.address)
      expect(await factory.owner()).to.eq(other.address)
    })

    it('emits event', async () => {
      await expect(factory.setOwner(other.address))
        .to.emit(factory, 'OwnerChanged')
        .withArgs(wallet.address, other.address)
    })

    it('cannot be called by original owner', async () => {
      await factory.setOwner(other.address)
      await expect(factory.setOwner(wallet.address)).to.be.reverted
    })
  })
})
