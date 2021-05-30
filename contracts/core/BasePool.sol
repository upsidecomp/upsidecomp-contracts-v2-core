// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import '../token/UpsidePoolToken.sol';

import '../libraries/FixedPoint.sol';
import '../token/helpers/ERC20.sol';

import '../interfaces/core/IBasePoolDeployer.sol';
import '../interfaces/core/IBasePool.sol';

import '../helpers/UpsideErrors.sol';

// todo: implement IVault to main the pools
// todo: implement AssetManager to access fee
// todo: implement Authroization
abstract contract BasePool is IBasePool, UpsidePoolToken {
    using FixedPoint for uint256;

    uint256 private constant _MIN_FEE_PERCENTAGE = 1e12; // 0.0001%
    uint256 private constant _MAX_FEE_PERCENTAGE = 1e17; // 10%

    uint256 public override feePercentage;

    mapping(bytes32 => mapping(address => uint256)) public balances;
    mapping(address => bytes32) private _poolIds;

    event PoolRegistered(bytes32 indexed poolId, address indexed owner);
    event FeePercentageUpdated(uint256 feePercentage);

    constructor(
        address owner,
        uint256 feePercentage,
        string memory name,
        string memory symbol
    ) UpsidePoolToken(name, symbol) {
        _setFeePercentage(feePercentage);
    }

    function registerOwner(address owner) external override returns (bytes32) {
        _require(_poolIds[owner] == bytes32(0x0), Errors.POOL_OWNER_EXIST);

        bytes32 poolId = _toPoodId(owner);

        _poolIds[owner] = poolId;

        emit PoolRegistered(poolId, owner);
        return poolId;
    }

    function _toPoodId(address _owner) internal pure returns (bytes32) {
        bytes32 serialized;

        serialized |= bytes32(keccak256(abi.encode(_owner))) << (10 * 8);

        return serialized;
    }

    function setFeePercentage(uint256 _feePercentage) external override {
        _setFeePercentage(_feePercentage);
    }

    function _setFeePercentage(uint256 _feePercentage) internal {
        require(_feePercentage >= _MIN_FEE_PERCENTAGE);
        require(_feePercentage <= _MAX_FEE_PERCENTAGE);

        feePercentage = _feePercentage;

        emit FeePercentageUpdated(_feePercentage);
    }
}
