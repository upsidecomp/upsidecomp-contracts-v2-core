// SPDX-License-Identifier: BUSL-1.1

pragma solidity ^0.8.0;

// import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
// import "@openzeppelin/contracts-upgradeable/utils/ReentrancyGuardUpgradeable.sol";
// import "@openzeppelin/contracts-upgradeable/token/ERC20/SafeERC20Upgradeable.sol";

import './interfaces/IUpsideV1Pool.sol';
import './interfaces/IUpsideV1PoolDeployer.sol';

import './core/BasePool.sol';

contract UpsideV1Pool is BasePool {}
