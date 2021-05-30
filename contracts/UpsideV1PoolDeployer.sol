// SPDX-License-Identifier: BUSL-1.1

pragma solidity ^0.8.0;

import './interfaces/IUpsideV1PoolDeployer.sol';

import './UpsideV1Pool.sol';

contract UpsideV1PoolDeployer is IUpsideV1PoolDeployer {
    struct Parameters {
        address factory;
        address owner;
        uint256 feePercentage;
    }

    Parameters public override parameters;

    function deploy(
        address factory,
        address owner,
        uint256 feePercentage
    ) internal returns (address pool) {
        parameters = Parameters({factory: factory, owner: owner, feePercentage: feePercentage});
        pool = address(new UpsideV1Pool{salt: keccak256(abi.encode(owner, feePercentage))}());
        delete parameters;
    }
}
