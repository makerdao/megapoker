# megapoker
![Build Status](https://github.com/makerdao/megapoker/actions/workflows/.github/workflows/tests.yaml/badge.svg?branch=master)
Optimized smart contract to poke and drip

For now, hard coded addresses and sequence. Easy for techops to run.

MegaPoker curent Mainnet Address: [0x18Bd1a35Caf9F192234C7ABd995FBDbA5bBa81ca](https://kovan.etherscan.io/address/0x18Bd1a35Caf9F192234C7ABd995FBDbA5bBa81ca#code)

# OmegaPoker

Extensible poker for Kovan and backup for Mainnet.

OmegaPoker Kovan Address: [0x7e2531587d25b9fc58aA051D0f19c0Ae809316E9](https://kovan.etherscan.io/address/0x7e2531587d25b9fc58aa051d0f19c0ae809316e9#code)

OmegaPoker Mainnet Address: [0xC848435494c548Cd4e3213A59521Cd21f74b8CF8](https://etherscan.io/address/0xC848435494c548Cd4e3213A59521Cd21f74b8CF8#code)

At the expense of a little gas, the OmegaPoker will gather pip addresses from the [Ilk Registry](https://github.com/makerdao/ilk-registry) and poke all collaterals without a redeployment.

## `OmegaPoker.refresh()`

Public function to reset all pips. Call this when a new collateral is added to kovan.

## `OmegaPoker.poke()`

Public function to poke all ilks. Call after `reset()`
