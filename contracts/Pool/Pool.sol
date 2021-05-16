pragma solidity 0.6.6;

import "../Token/Karma.sol"

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/util/ReentrancyGuardUpgradeable.sol";

import "../utils/MappedSinglyLinkedList.sol";
import "../Token/Karma.sol"


contract Pool is OwnableUpgradeable, ReentrancyGuardUpgradeable {
    using MappedSinglyLinkedList for MappedSinglyLinkedList.Mapping;

    event Initialized(
        address creator
    );

    event Deposited(
        address index from,
        uint256 amount
    );

    event Withdrawn(
    );

    struct Mapping {
        mapping(address => uint256) public balances;
    };

    Karma public karma;

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

    function deposit(uint256 amount) public payable {
        require(msg.sender != _owner);

        msg.sender.transfer(amount);

        balances[msg.sender] += amount;

        emit Deposited(msg.sender, to, amount)
    }

    function balance() public view returns (uint256) {
        require(msg.sender != _owner)

        return balance[msg.sender];
    }

    function owner() public view returns (address) {
        return _owner;
    }
}
