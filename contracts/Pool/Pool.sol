pragma solidity 0.6.6;

import "../Token/Karma.sol"

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/ReentrancyGuardUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/SafeERC20Upgradeable.sol";

import "../utils/MappedSinglyLinkedList.sol";
import "../token/Karma.sol"


// @todo:
// 1. Remove Karma & add ControlledToken -- includes Karma + Sponsor
// 2. Identify how ERC1155 enables ERC721
// 3. Address can be DID? Can we switch addr?
contract Pool is OwnableUpgradeable, ReentrancyGuardUpgradeable {
    using MappedSinglyLinkedList for MappedSinglyLinkedList.Mapping;

    event Initialized(
        address creator
    );

    event Deposited(
        address indexed operator,
        address indexed to,
        address indexed token,
        uint256 amount,
    );

    event Withdrawn(
    );

    struct Mapping {
        mapping(address => uint256) public balances;
    };

    Karma public karma;

    function depositTo(
        address to,
        uint256 amount,
        address controlledToken,
    )
        external override
        onlyControlledToken(controlledToken)
        canAddLiquidity(amount)
        nonReentrant
    {
        address operator = _msgSender();

        _mint(to, amount, controlledToken);

        _token().safeTransferFrom(operator, address(this), amount);

        emit Deposited(operator, to, controlledToken, amount);
    }

    function initialize (
        KarmaInterface memory _karma
    )
        public
        initializer
    {
        require(msg.sender != address(0));
        __Ownable_init();
        __ReentrancyGuard_init();

        karma = _karma;

        emit Initialized(msg.sender);
    }

    function balance() public view returns (uint256) {
        require(msg.sender != _owner)

        return balance[msg.sender];
    }

    function owner() public view returns (address) {
        return _owner;
    }

    function _mint(address to, uint256 amount, address controlledToken) internal {
        // if (address(prizeStrategy) != address(0)) {
        //   prizeStrategy.beforeTokenMint(to, amount, controlledToken, referrer);
        // }
        ControlledToken(controlledToken).controllerMint(to, amount);
    }

    function _token() internal virtual view returns (IERC20Upgradeable);
}
