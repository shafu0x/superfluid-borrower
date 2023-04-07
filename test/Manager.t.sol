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
  ISuperToken public collateral;

  function setUp() public {
    manager = new Manager(
      ISuperToken(ETHx),
      ISuperToken(USDCx),
      IAggregatorV3(ORACLE)
    );
    collateral = ISuperToken(ETHx);
  } 

  function testDeposit() public {
    deal(ETHx, address(this), 1e18 ether);
    collateral.setMaxFlowPermissions(address(manager));
    manager.deposit(1);
  }
}
