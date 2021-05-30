// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import './interfaces/IUpsideV1Factory.sol';

import './UpsideV1PoolDeployer.sol';

import './UpsideV1Pool.sol';

/// @title Canonical Uniswap V3 factory
/// @notice Deploys Uniswap V3 pools and manages ownership and control over pool protocol fees
contract UpsideV1Factory is IUpsideV1Factory, UpsideV1PoolDeployer {
    /// @inheritdoc IUpsideV1Factory
    address public override owner;

    /// @inheritdoc IUpsideV1Factory
    address public override pool;

    constructor() {
        owner = msg.sender;
        emit OwnerChanged(address(0), msg.sender);
    }

    /// @inheritdoc IUpsideV1Factory
    function createPool(uint256 _feePercentage) external override returns (address) {
        pool = deploy(address(this), _feePercentage);
        emit PoolCreated(_feePercentage, pool);
        return pool;
    }

    /// @inheritdoc IUpsideV1Factory
    function setOwner(address _owner) external override {
        require(msg.sender == owner);
        emit OwnerChanged(owner, _owner);
        owner = _owner;
    }
}
