pragma solidity =0.5.16;

import "./interfaces/IUpsideV1Factory.sol";
import "./interfaces/IUpsideV1Pool.sol";
import "./UpsideV1Pool.sol";


contract UpsideV1PoolFactory is IUpsideV1Factory {
    address public feeTo;
    address public feeToSetter;

    mapping(address => address) public getPool;
    address[] public allPools;

    event PoolCreated(address indexed owner, address indexed token, address pool);

    constructor(address _feeToSetter) public {
        feeToSetter = _feeToSetter;
    }

    function createPool(address owner) external returns (address pool) {
        require(owner != address(0), "UpsideV1: ZERO_ADDRESS_OWNER");
        require(getPool[owner] == address(0), "UpsideV1: OWNER_EXISTS");

        bytes memory bytecode = type(UpsideV1Pool).creationCode;
        bytes32 salt = keccak256(abi.encodePacked(owner));

        assembly {
            pool := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }

        IUpsideV1Pool(pool).initialize(owner);
        getPool[owner] = pool;
        allPools.push(pool);

        // todo: fix this with a token
        emit PoolCreated(owner, pool, pool);
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
