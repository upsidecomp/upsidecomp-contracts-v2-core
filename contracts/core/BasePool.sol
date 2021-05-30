// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import '../token/UpsidePoolToken.sol';

import '../libraries/FixedPoint.sol';
import '../token/helpers/ERC20.sol';

import '../interfaces/core/IBasePoolDeployer.sol';
import '../interfaces/core/IBasePool.sol';

// todo: implement IVault to main the pools
// todo: implement AssetManager to access fee
abstract contract BasePool is IBasePool {
    using FixedPoint for uint256;

    uint256 private constant _MIN_FEE_PERCENTAGE = 1e12; // 0.0001%
    uint256 private constant _MAX_FEE_PERCENTAGE = 1e17; // 10%

    // IVault private immutable _vault;
    // bytes32 private immutable _poolId;
    // uint256 private immutable _totalTokens;

    address public immutable override factory;
    address public immutable override owner;
    uint256 public override feePercentage;

    constructor() {
        (factory, owner, feePercentage) = IBasePoolDeployer(msg.sender).parameters();
    }
}
