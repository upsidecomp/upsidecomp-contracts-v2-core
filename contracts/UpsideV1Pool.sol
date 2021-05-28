pragma solidity =0.5.16;

// import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
// import "@openzeppelin/contracts-upgradeable/utils/ReentrancyGuardUpgradeable.sol";
// import "@openzeppelin/contracts-upgradeable/token/ERC20/SafeERC20Upgradeable.sol";

import "./interfaces/IUpsideV1Pool.sol";
import "./UpsideV1ERC20.sol";


// @todo:
// 1. Remove Karma & add ControlledToken -- includes Karma + Sponsor
// 2. Identify how ERC1155 enables ERC721
// 3. Address can be DID? Can we switch addr?
// 4. Functions: Deposit, Withdraw, Transfer.
contract UpsideV1Pool is IUpsideV1Pool, UpsideV1ERC20 {

    address public factory;
    address public owner;

    constructor() public {
        factory = msg.sender;
    }

    function initialize(address _owner) external {
        require(msg.sender == factory, "UpsideV1: FORBIDDEN");
        owner = _owner;
    }
}
