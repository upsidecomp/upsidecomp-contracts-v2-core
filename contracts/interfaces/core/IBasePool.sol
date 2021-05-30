// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import '../pool/IBasePoolImmutables.sol';
import '../pool/IBasePoolOwnerActions.sol';
import '../pool/IBasePoolState.sol';

interface IBasePool is IBasePoolImmutables, IBasePoolOwnerActions, IBasePoolState {}
