pragma solidity 0.6.6;


interface IUpsidePool {
    function owner() external view returns (address);
    function totalSupply() external view returns (uint);
}
