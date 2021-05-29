import { utils } from "ethers";

export enum FeeAmount {
  LOW = 500,
  MEDIUM = 3000,
  HIGH = 10000,
}

export function getCreate2Address(
  _factoryAddress: string,
  _owner: string,
  _fee: number,
  bytecode: string
): string {
  const owner = _owner.toLowerCase();
  const fee = _fee;
  const factoryAddress = _factoryAddress;

  const constructorArgumentsEncoded = utils.defaultAbiCoder.encode(
    ["address", "uint24"],
    [owner, fee]
  );
  const create2Inputs = [
    "0xff",
    factoryAddress,
    // salt
    utils.keccak256(constructorArgumentsEncoded),
    // init code. bytecode + constructor arguments
    utils.keccak256(bytecode),
  ];
  const sanitizedInputs = `0x${create2Inputs.map((i) => i.slice(2)).join("")}`;
  return utils.getAddress(`0x${utils.keccak256(sanitizedInputs).slice(-40)}`);
}
