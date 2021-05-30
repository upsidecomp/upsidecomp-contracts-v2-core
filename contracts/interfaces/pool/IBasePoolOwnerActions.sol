// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.5.0;

interface IBasePoolOwnerActions {
    function setFeeProtocol(uint256 feePercentage) external;

    function registerOwner(address owner) external returns (bytes32);
}
