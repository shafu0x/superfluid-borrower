# Superfluid - Borrowing/Lending

## Description 
This contract is designed to manage collateralized loans in Superfluid streams. It allows borrowers to deposit collateral streams, borrow funds as streams, and repay the borrowed amount in streams. The contract enforces a minimum collateralization ratio of 150% by locking borrower's collateral in the contract. The contract also fetches the latest ETH/USD price from an Oracle contract to ensure that the minimum collateralization ratio is maintained.

## Dependencies
- `Solidity 0.8.13`
- `@openzeppelin/contracts 4.3.0`
- `@solmate/src 0.1.9`
- `@superfluid-finance/contracts 2.1.2`
- `IAggregatorV3` - an interface for fetching ETH/USD price from an Oracle contract

## Usage
1. Deploy the Manager contract. The Manager contract requires an instance of the `IAggregatorV3` interface for fetching ETH/USD price.
2. Users can deposit collateral (i.e. SuperToken) into the contract by calling the `depositCollat` function with a desired `flowRate`.
3. Users can then borrow funds (i.e. SuperToken) from the contract by calling the `borrow` function with a desired `flowRate`.
4. Users can repay the borrowed amount by transferring the appropriate amount of SuperToken into the contract using the `depositDebt` function.
5. Users can close their loan by calling the `close` function to reclaim their collateral.
6. If a borrower's collateralization ratio falls below the minimum threshold, the `liquidate` function can be called to liquidate the borrower's collateral and repay the loan.

## Functions
- `depositCollat(int96 flowRate)` - allows a user to deposit collateral.
- `depositDebt(uint amount)` - allows a user to deposit funds to repay their borrowed amount.
- `update(int96 flowRate)` - updates a borrower's flow rate.
- `borrow(int96 flowRate)` - allows a user to borrow funds.
- `close()` - allows a borrower to reclaim their collateral.
- `liquidate(address borrower)` - liquidates a borrower's collateral if their collateralization ratio falls below the minimum threshold.
