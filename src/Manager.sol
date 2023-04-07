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

contract Manager {
  using SuperTokenV1Library for ISuperToken;

  ISuperToken public collateral;
  ISuperToken public debt;

  uint public constant MIN_COLLAT_RATIO = 1.5e18; // 150%

  mapping (address => bool) public isBorrower;
  
  constructor(
    ISuperToken _collateral,
    ISuperToken _debt
  ) {
    collateral = _collateral;
    debt       = _debt;
  }

  function deposit(int96 flowRate) public {
    require(!isBorrower[msg.sender]);
    isBorrower[msg.sender] = true;
    collateral.createFlowFrom(
      msg.sender,
      address(this),
      flowRate
    );
  }

  function update(int96 flowRate) public {
    collateral.updateFlow(address(this), flowRate);
  }

  function borrow(uint amount) public {
  }

  function close() public {
    require(isBorrower[msg.sender]);
    isBorrower[msg.sender] = false;
    collateral.deleteFlow(msg.sender, address(this));
  }

  function liquidate(address borrower) public {
  }
}
