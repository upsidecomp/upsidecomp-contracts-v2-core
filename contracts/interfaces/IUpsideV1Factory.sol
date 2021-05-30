// SPDX-License-Identifier: BUSL-1.1
pragma solidity >=0.5.0;

/// @title The interface for the Upside V1 Factory
/// @notice The Upside V1 Factory facilitates creation of Uniswap V3 pools and control over the protocol fees
interface IUpsideV1Factory {
    event OwnerChanged(address indexed oldOwner, address indexed newOwner);

    event PoolCreated(address indexed owner, uint256 indexed feePercentage, address pool);

    function owner() external view returns (address);

    function getPool(address _owner) external view returns (address pool);

    function createPool(address _owner, uint256 _feePercentage) external returns (address pool);

    function setOwner(address _owner) external;
}
