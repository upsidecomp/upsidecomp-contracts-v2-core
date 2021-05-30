// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

interface IBasePoolDeployer {
    function parameters() external view returns (address factory, uint256 feePercentage);
}
