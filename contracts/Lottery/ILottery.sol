pragma solidity 0.6.6;


interface LotteryInterface {
    function start(uint) public;
    function end(uint) public;
    function draw(uint) public;
}
