pragma solidity 0.6.6;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/ReentrancyGuardUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/SafeERC20Upgradeable.sol";


// @todo:
// 1. Remove Karma & add ControlledToken -- includes Karma + Sponsor
// 2. Identify how ERC1155 enables ERC721
// 3. Address can be DID? Can we switch addr?
// 4. Functions: Deposit, Withdraw, Transfer.
contract UpsideV1Pool is IUpsideV1Pair, UpsideV1ERC20 {

    address public factory;
    address public owner;

    constructor() public {
        factory = msg.sender;
    }

    function intialize(address _owner) external {
        require(msg.sender == factory, "UpsideV2: FORBIDDEN");
        owner = _owner;
    }
}
