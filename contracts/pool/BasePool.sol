// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import '../token/UpsidePoolToken.sol';

// import '../interfaces/pool/IBasePool';

import '../libraries/FixedPoint.sol';
import '../token/helpers/ERC20.sol';

// todo: implement IVault to main the pools
// todo: implement AssetManager to access fee
abstract contract BasePool is UpsidePoolToken {
    using FixedPoint for uint256;

    uint256 private constant _MIN_FEE_PERCENTAGE = 1e12; // 0%
    uint256 private constant _MAX_FEE_PERCENTAGE = 5e17; // 50%

    uint256 internal _feePercentage;

    // IVault private immutable _vault;
    // bytes32 private immutable _poolId;
    // uint256 private immutable _totalTokens;

    IERC20 internal immutable _token;
    uint256 internal immutable _scalingFactor;

    constructor(
        string memory name,
        string memory symbol,
        IERC20 token,
        address[] memory assetManagers,
        uint256 feePercentage,
        address owner
    ) UpsidePoolToken(name, symbol) {
        _setFeePercentage(feePercentage);

        // bytes32 poolId = vault.registerPool(specialization);
        // vault.registerToken(poolId, token, assetManagers);
        // _poolId = poolId;
        // _vault = vault;

        _token = token;

        _scalingFactor = _computeScalingFactor(token);
    }

    function _setFeePercentage(uint256 feePercentage) private {
        require(feePercentage >= _MIN_FEE_PERCENTAGE);
        require(feePercentage <= _MAX_FEE_PERCENTAGE);
        _feePercentage = feePercentage;
        // emit FeePercentageChanged(owner, feePercentage);
    }

    /**
     * @dev Returns a scaling factor that, when multiplied to a token amount for `token`, normalizes its balance as if
     * it had 18 decimals.
     */
    function _computeScalingFactor(IERC20 token) private view returns (uint256) {
        // Tokens that don't implement the `decimals` method are not supported.
        uint256 tokenDecimals = ERC20(address(token)).decimals();

        // Tokens with more than 18 decimals are not supported.
        uint256 decimalsDifference = Math.sub(18, tokenDecimals);
        return 10**decimalsDifference;
    }
}
