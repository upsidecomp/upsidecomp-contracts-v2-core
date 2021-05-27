pragma solidity 0.6.6;

import "./interfaces/IUpsideV1Factory.sol";
import "./UpsideV1Pool.sol";


contract UpsideV1PoolFactory is IUpsideV1Factory {
    address public feeTo;
    address public feeToSetter;

    mapping(address => mapping(address => uint)) public getPool;
    address[] public allPools;

    event PoolCreated(address indexed owner, address indexed token, address pool);

    constructor(address _feeToSetter) public {
        feeToSetter = _feeToSetter;
    }

    function createPool(address owner) external returns (address pool) {
        require(owner != address(0), "UpsideV1: ZERO_ADDRESS_OWNER");
        require(getPair[owner] == address(0), "UpsideV1: OWNER_EXISTS");

        bytes memory bytecode = type(UpsideV1Pool).creationCode;
        bytes32 salt = keccak256(abi.encodePacked(owner));

        assembly {
            pool := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }

        IUpsideV1Pool(pair).initialize(owner);
        getPool[owner] = pool;
        allPairs.push(pool);

        emit PoolCreated(owner, token, pool)
    }

    function setFeeTo(address _feeTo) external {
        require(msg.sender == feeToSetter, "UpsideV1: FORBIDDEN");
        feeTo = _feeTo;
    }

    function setFeeToSetter(address _feeToSetter) external {
        require(msg.sender == feeToSetter, "UpsideV1: FORBIDDEN");
        feeToSetter = _feeToSetter;
    }
}
