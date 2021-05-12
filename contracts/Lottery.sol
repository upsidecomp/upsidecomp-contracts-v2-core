pragma solidity ^0.6.6;

import "@chainlink/contracts/src/v0.6/ChainlinkClient.sol";
import "./Governance.sol";
import "./RandomnessInterface.sol"

contract Lottery is ChainlinkClient {
  /* Enum LOTERRY_STATE -- Types of State*/
  enum LOTTERY_STATE { OPEN, CLOSED, CALCULATING_WINNER }

  /* LOTERRY_STATE -- Keeps track of the state of a lottery */
  LOTTERY_STATE public lottery_state;

  /* Player Addresses */
  address payable[] public players;
  uint256 public lotteryId;

  constructor() public {
      setPublicChainlinkToken();
      lotteryId = 1;
      lottery_state = LOTTERY_STATE.CLOSED;
  }

  function start(uint256 duration) public {
   require(lottery_state == LOTTERY_STATE.CLOSED, "cant start a new lottery yet");

   lottery_state = LOTTERY_STATE.OPEN;

   Chainlink.Request memory req = buildChainlinkRequest(CHAINLINK_ALARM_JOB_ID, address(this), this.fulfill_alarm.selector);
   req.addUint("until", now + duration);

   sendChainlinkRequestTo(CHAINLINK_ALARM_ORACLE, req, ORACLE_PAYMENT);
 }

 function end(bytes32 _requestId) public recordChainlinkFulfillment(_requestId) {
   require(lottery_state == LOTTERY_STATE.OPEN, "The lottery hasnt even started!");

   lottery_state = LOTTERY_STATE.CALCULATING_WINNER;
   draw();

   lotteryId = lotteryId + 1;
 }

 function enter() public payable {
   assert(msg.value == MINIMUM);
   assert(lottery_state == LOTTERY_STATE.OPEN);
   players.push(msg.sender);
  }

  function draw() private {
    require(lottery_state == LOTTERY_STATE.CALCULATING_WINNER, "You arent at that stage yet!");
    RandomnessInterface(governance.randomness()).getRandom(lotteryId, lotteryId);
    //this kicks off the request and returns through fulfill_random
  }
}
