// SPDX-License-Identifier: BUSL-1.1

pragma solidity ^0.8.0;

import "./interfaces/IUpsideV1PoolDeployer.sol";

import "./UpsideV1Pool.sol";

contract UpsideV1PoolDeployer is IUpsideV1PoolDeployer {
    struct Parameters {
        address owner;
        address factory;
        uint24 fee;
    }

    Parameters public override parameters;

    function deploy(
        address factory,
        address owner,
        uint24 fee
    ) internal returns (address pool) {
        parameters = Parameters({factory: factory, owner: owner, fee: fee});
        pool = address(
            new UpsideV1Pool{salt: keccak256(abi.encode(owner, fee))}()
        );
        delete parameters;
    }
}
