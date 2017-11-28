pragma solidity ^0.4.17;

import './Ownable.sol';

contract Pausable is Ownable {
  event Pause();
  event Unpause();

  bool public paused = true;

  modifier whenNotPaused() {
    require(!paused);
    _;
  }

  modifier whenPaused() {
    require(paused);
    _;
  }

  function pause() onlyOwner whenNotPaused {
    paused = true;
    Pause();
  }

  function unpause() onlyOwner whenPaused {
    paused = false;
    Unpause();
  }
}