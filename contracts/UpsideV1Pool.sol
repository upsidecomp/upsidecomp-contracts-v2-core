pragma solidity 0.6.6;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/ReentrancyGuardUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/SafeERC20Upgradeable.sol";


// @todo:
// 1. Remove Karma & add ControlledToken -- includes Karma + Sponsor
// 2. Identify how ERC1155 enables ERC721
// 3. Address can be DID? Can we switch addr?
// 4. Functions: Deposit, Withdraw, Transfer.
contract UpsidePool is OwnableUpgradeable, ReentrancyGuardUpgradeable {
    struct Mapping {
        mapping(address => uint256) public balances;
    }

    mapping(address => Mapping) public ownable;

    function createPool() public {
        require(ownable[msg.sender] == address(0x0));

        ownable[msg.sender] =
    }
}
