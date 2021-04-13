# megapoker

Optimized smart contract to poke and drip

For now, hard coded addresses and sequence. Easy for techops to run.

# OmegaPoker

Extensible poker for Kovan.

At the expense of a little gas, the OmegaPoker will gather pip addresses from the [Ilk Registry](https://github.com/makerdao/ilk-registry) and poke all collaterals without a redeployment.

## `OmegaPoker.refresh()`

Public function to reset all pips. Call this when a new collateral is added to kovan.

## `OmegaPoker.poke()`

Public function to poke all ilks. Call after `reset()`
