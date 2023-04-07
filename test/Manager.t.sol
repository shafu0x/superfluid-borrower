// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import { 
    ISuperToken 
} from "@superfluid-finance/contracts/interfaces/superfluid/ISuperToken.sol";
import {
    SuperTokenV1Library
} from "@superfluid-finance/contracts/apps/SuperTokenV1Library.sol";

import {Manager} from "../src/Manager.sol";
import {IAggregatorV3} from "../src/interfaces/IAggregatorV3.sol";
import {ETHx, USDCx, ORACLE} from "../src/Parameters.sol";

contract ManagerTest is Test {
  using SuperTokenV1Library for ISuperToken;

  Manager     public manager;
  ISuperToken public collat;
  ISuperToken public debt;

  function setUp() public {
    manager = new Manager(
      ISuperToken(ETHx),
      ISuperToken(USDCx),
      IAggregatorV3(ORACLE)
    );
    collat = ISuperToken(ETHx);
    debt   = ISuperToken(USDCx);

    deal(ETHx,  address(this), 1e18 ether);
    deal(USDCx, address(this), 1e18 ether);
    deal(ETHx,  address(manager), 1e18 ether);
    deal(USDCx, address(manager), 1e18 ether);
    collat.setMaxFlowPermissions(address(manager));
    debt.  setMaxFlowPermissions(address(manager));
  } 

  // function testDepositCollat() public {
  //   manager.depositCollat(1);
  // }

  // function testDepositDebt() public {
  //   debt.approve(address(manager), 100);
  //   manager.depositDebt(100);
  // }

  function testBorrow() public {
    debt.approve(address(manager), 1e18);
    manager.depositDebt(1e18);
    manager.depositCollat(1e15);
    manager.borrow(1);
  }
}
