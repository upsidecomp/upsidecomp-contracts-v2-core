// SPDX-License-Identifier: BUSL-1.1

pragma solidity ^0.8.0;

// import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
// import "@openzeppelin/contracts-upgradeable/utils/ReentrancyGuardUpgradeable.sol";
// import "@openzeppelin/contracts-upgradeable/token/ERC20/SafeERC20Upgradeable.sol";

import './interfaces/IUpsideV1Pool.sol';
import './interfaces/IUpsideV1PoolDeployer.sol';

// @todo:
// 1. Remove Karma & add ControlledToken -- includes Karma + Sponsor
// 2. Identify how ERC1155 enables ERC721
// 3. Address can be DID? Can we switch addr?
// 4. Functions: Deposit, Withdraw, Transfer.
contract UpsideV1Pool is IUpsideV1Pool {
    address public immutable override factory;

    address public immutable override owner;

    uint24 public immutable override fee;

    constructor() public {
        (factory, owner, fee) = IUpsideV1PoolDeployer(msg.sender).parameters();
    }
}
