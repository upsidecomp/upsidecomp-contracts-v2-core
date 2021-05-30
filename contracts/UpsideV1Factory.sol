// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import "./interfaces/IUpsideV1Factory.sol";

import "./UpsideV1PoolDeployer.sol";

import "./UpsideV1Pool.sol";

/// @title Canonical Uniswap V3 factory
/// @notice Deploys Uniswap V3 pools and manages ownership and control over pool protocol fees
contract UpsideV1Factory is IUpsideV1Factory, UpsideV1PoolDeployer {
    /// @inheritdoc IUpsideV1Factory
    address public override owner;

    /// @inheritdoc IUpsideV1Factory
    mapping(address => address) public override getPool;

    constructor() {
        owner = msg.sender;
        emit OwnerChanged(address(0), msg.sender);
    }

    /// @inheritdoc IUpsideV1Factory
    function createPool(address _owner, uint24 _fee) external override returns (address pool) {
        require(_owner != address(0), "UpsideV1: ZERO_ADDRESS");
        require(getPool[_owner] == address(0));

        pool = deploy(address(this), _owner, _fee);
        getPool[_owner] = pool;

        emit PoolCreated(_owner, _fee, pool);
    }

    /// @inheritdoc IUpsideV1Factory
    function setOwner(address _owner) external override {
        require(msg.sender == owner);
        emit OwnerChanged(owner, _owner);
        owner = _owner;
    }
}
