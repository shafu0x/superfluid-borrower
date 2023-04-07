// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { 
    ISuperToken 
} from "@superfluid-finance/contracts/interfaces/superfluid/ISuperToken.sol";

import {Manager} from "../src/Manager.sol";
import {WETH, USDC} from "../src/Parameters.sol";

contract ManagerTest {
  Manager public manager;

  function setUp() public {
    manager = new Manager(
      ISuperToken(WETH),
      ISuperToken(USDC)
    );
  } 

  function testDeposit() public {
    // TODO
  }
}
