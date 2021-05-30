// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import '../token/UpsidePoolToken.sol';

import '../libraries/FixedPoint.sol';
import '../token/helpers/ERC20.sol';

import '../interfaces/pool/IBasePoolDeployer.sol';
import '../interfaces/pool/IBasePool.sol';

abstract contract BasePool is IBasePool {
    address public immutable override factory;
    address public immutable override owner;
    uint256 public immutable override feePercentage;

    constructor() {
        (factory, owner, feePercentage) = IBasePoolDeployer(msg.sender).parameters();
    }
}
