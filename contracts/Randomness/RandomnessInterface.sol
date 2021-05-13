pragma solidity 0.6.6;

interface RandomnessInterface {
    function randomNumber(uint) external view returns (uint);
    function getRandom(uint, uint) external;
}
