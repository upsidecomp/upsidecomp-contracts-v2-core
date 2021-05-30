import { utils } from 'ethers'

export enum FeeAmount {
  LOW = 1e12,
  MEDIUM = 1e13,
  HIGH = 1e14,
}

export function getCreate2Address(
  factoryAddress: string,
  owner: string,
  feePercentage: number,
  bytecode: string
): string {
  const constructorArgumentsEncoded = utils.defaultAbiCoder.encode(['address', 'uint256'], [owner, feePercentage])
  const create2Inputs = [
    '0xff',
    factoryAddress,
    // salt
    utils.keccak256(constructorArgumentsEncoded),
    // init code. bytecode + constructor arguments
    utils.keccak256(bytecode),
  ]
  const sanitizedInputs = `0x${create2Inputs.map((i) => i.slice(2)).join('')}`
  return utils.getAddress(`0x${utils.keccak256(sanitizedInputs).slice(-40)}`)
}
