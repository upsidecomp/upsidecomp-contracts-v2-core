// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

// import './IVault.sol';
// import './IPoolSwapStructs.sol';

interface IBasePool {
    function onJoinPool(
        bytes32 poolId,
        address sender,
        address recipient,
        uint256 lastChangeBlock,
        bytes memory userData
    ) external returns (uint256[] memory amountsIn, uint256[] memory dueProtocolFeeAmounts);

    function onExitPool(
        bytes32 poolId,
        address sender,
        address recipient,
        uint256 lastChangeBlock,
        bytes memory userData
    ) external returns (uint256[] memory amountsOut, uint256[] memory dueProtocolFeeAmounts);
}
