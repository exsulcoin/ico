pragma solidity ^0.4.17;

import "./MintableToken.sol";
import "./Pausable.sol";

/**
 * @title XulToken
 * @dev ERC20 Token that can be minted with a preico period with a goal.
 * It is meant to be used in XulCrowdsale contract.
 */
contract XulToken is MintableToken, Pausable {

  string public constant name = "XULToken";
  string public constant symbol = "XUL";
  uint8 public constant decimals = 18;

  uint256 public preIcoEndDate = 1510704000;  

  function XulToken() {
  }
  
  /**
   * @dev This mint overrides the original provided by the framework.
   * It receive an address and a uint256.
   * It checks a goal if the preicodate is true.
   * In case that the goal was reached, the token pause itself.
   */   
  function mint(address _to, uint256 _amount) onlyOwner canMint whenNotPaused public returns (bool) {
    uint256 goal = 300000000 * (10**18);

    if (isPreIcoDate()) {
      uint256 sum = totalSupply.add(_amount);
      require(sum <= goal);
    }

    totalSupply = totalSupply.add(_amount);
    balances[_to] = balances[_to].add(_amount);
    Mint(_to, _amount);
    Transfer(0x0, _to, _amount);
    if (totalSupply == goal && isPreIcoDate()) {
      paused = true;
    }
    return true;    
  }
  
  /**
   * @dev Makes a mint without checking conditions of standard mint.
   * It doesn't add to the totalSupply.  
   */     
  function superMint(address _to, uint256 _amount) onlyOwner canMint public returns (bool) {
    balances[_to] = balances[_to].add(_amount);
    Mint(_to, _amount);
    Transfer(0x0, _to, _amount);
    return true;
  }     
  
  /**
   * @dev Change token preIcoEndDate.
   * It receives a timestamp  
   */  
  function changePreIcoEndDate(uint256 _preIcoEndDate) onlyOwner public {
    require(_preIcoEndDate > 0);
    preIcoEndDate = _preIcoEndDate;
  }  

  /**
   * @dev Returns true if preIcoEndDate is in the future.
   */  
  function isPreIcoDate() public returns(bool) {
    return now <= preIcoEndDate;
  }     
  
}