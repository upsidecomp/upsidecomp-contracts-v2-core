// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import '../token/UpsidePoolToken.sol';

// import '../interfaces/pool/IBasePool';

import '../libraries/FixedPoint.sol';

abstract contract BasePool is UpsidePoolToken {
    using FixedPoint for uint256;
}
