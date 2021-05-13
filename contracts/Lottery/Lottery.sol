pragma solidity 0.6.6;

import "./Governance.sol";
import "./RandomnessInterface.sol"


contract Lottery {
    /* Enum LOTERRY_STATE -- Types of State*/
    enum LotteryState {
        OPEN,
        CLOSED,
        CALCULATING_WINNER
    }

    struct Lottery {
        LotteryState lotteryState;
        address payable[] public players; /* Player Addresses */
        uint256 public lotteryId; /* ID of the lottery -- count */
    }

    constructor() public { }

    function start() public {
        require(State == State.CLOSED, "cant start a new lottery yet");

        lotteryId += 1;
        State = State.OPEN;
    }

    function end() public {
        require(State == State.OPEN, "The lottery hasnt even started!");
        // = State.CALCULATING_WINNER;
        draw();
    }

    function enter() public payable {
        assert(msg.value == MINIMUM);
        assert(State == State.OPEN);
        players.push(msg.sender);
    }

    function draw() private {
        require(State == State.CALCULATING_WINNER, "You arent at that stage yet!");
        RandomnessInterface(governance.randomness()).getRandom(lotteryId, lotteryId);
        State = LOTTERY_STATE.CLOSED
    }
}
