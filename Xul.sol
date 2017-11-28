pragma solidity ^0.4.17;

import "./Crowdsale.sol";
import "./XulToken.sol";
import "./MintableToken.sol";
import "./Pausable.sol";
import "./Ownable.sol";

/**
 * @title XulCrowdsale
 * @dev This is the crowdsale for XUL.
 * It has the control over the token for mint, unnmint and pause operations.
 * Also, it offers the capability to change start and end date of the crowdsale by the owner.
 */
contract XulCrowdsale is Crowdsale, Ownable {
    
  XulToken public xultoken;
    
  function XulCrowdsale(uint256 _startTime, uint256 _endTime, uint256 _rate, address _wallet)
    Crowdsale(_startTime, _endTime, _rate, _wallet)
  {
    
  }
  
  function createTokenContract() internal returns (MintableToken) {
     xultoken = new XulToken();
     return xultoken;
  }
  
  /**
   * @dev This function changes crowdsale rate.
   * It receive a uint256 and returns a bool
   */   
  function changeRate(uint256 _rate) public onlyOwner returns (bool){
      require(_rate > 0);
      rate = _rate;
  }
  
  /**
   * @dev Executes pause operation of the token
   */     
  function pauseToken() public onlyOwner returns(bool){
      xultoken.pause();
  }
  
  /**
   * @dev Executes unpause operation of the token
   */    
  function unpauseToken() public onlyOwner returns(bool){
      xultoken.unpause();
  }

  /**
   * @dev Executes mint operation of the token
   * It receives an address and a uint256
   */  
  function mintToken(address _to, uint256 _amount) public onlyOwner returns(bool){
      xultoken.mint(_to, _amount * (10 ** 18));
  }

  /**
   * @dev Function to made many mints in the same transaction
   * It receives an array of address and an array of uint256
   */
  function mintBulk(address[] _receivers, uint256[] _amounts) onlyOwner public {
    require(_receivers.length == _amounts.length);
    for (uint i = 0; i < _receivers.length; i++) {
        mintToken(_receivers[i], _amounts[i]);
    }
  } 
  
  /**
   * @dev Executes superMint operation of the token
   * It receives an address and a uint256
   */  
  function superMint(address _to, uint256 _amount) public onlyOwner returns(bool) {
      xultoken.superMint(_to, _amount * (10 ** 18));
  }
  
  /**
   * @dev This function changes crowdsale startTime.
   * It receives a timestamp
   */    
  function setStartTime(uint256 _startTime) public onlyOwner {
      require(_startTime > 0);
      startTime = _startTime;
  }  

  /**
   * @dev This function changes crowdsale endTime.
   * It receives a timestamp
   */      
  function setEndTime(uint256 _endTime) public onlyOwner {
      require(_endTime > 0);
      endTime = _endTime;
  }    

  /**
   * @dev Executes changePreIcoEndDate operation of the token
   * It receives a timestamp
   */    
  function setPreIcoEndDate(uint256 _preIcoEndDate) public onlyOwner {
    xultoken.changePreIcoEndDate(_preIcoEndDate);
  }  
}