// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import { 
    ISuperfluid 
} from "@superfluid-finance/contracts/interfaces/superfluid/ISuperfluid.sol";
import { 
    ISuperToken 
} from "@superfluid-finance/contracts/interfaces/superfluid/ISuperToken.sol";
import {
    SuperTokenV1Library
} from "@superfluid-finance/contracts/apps/SuperTokenV1Library.sol";
import {IAggregatorV3} from "./interfaces/IAggregatorV3.sol";

contract Manager {
  using SuperTokenV1Library for ISuperToken;

  IAggregatorV3 public oracle;

  ISuperToken public collat;
  ISuperToken public debt;

  uint public constant MIN_COLLAT_RATIO = 1.5e18; // 150%

  mapping (address => uint) public liquidity;
  mapping (address => bool) public isBorrower;
  
  constructor(
    ISuperToken   _collat,
    ISuperToken   _debt, 
    IAggregatorV3 _oracle 
  ) {
    collat = _collat;
    debt   = _debt;
    oracle = _oracle;
  }

  function depositCollat(int96 flowRate) public {
    require(!isBorrower[msg.sender]);
    isBorrower[msg.sender] = true;
    collat.createFlowFrom(
      msg.sender,
      address(this),
      flowRate
    );
  }

  function depositDebt(uint amount) public {
    debt.transferFrom(msg.sender, address(this), amount);
    liquidity[msg.sender] += amount;
  }

  function update(int96 flowRate) public {
    collat.updateFlow(address(this), flowRate);
  }

  function borrow(uint amount) public {
  }

  function close() public {
    require(isBorrower[msg.sender]);
    isBorrower[msg.sender] = false;
    collat.deleteFlow(msg.sender, address(this));
  }

  function liquidate(address borrower) public {
  }

  // ETH price in USD
  function _getEthPrice() 
    private 
    view 
    returns (int) {
      (
        uint80 roundID,
        int256 price,
        , 
        uint256 timeStamp, 
        uint80 answeredInRound
      ) = oracle.latestRoundData();
      require(timeStamp != 0);
      require(answeredInRound >= roundID);
      return price;
  }
}
