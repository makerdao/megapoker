# MegaPoker
![Build Status](https://github.com/makerdao/megapoker/actions/workflows/.github/workflows/tests.yaml/badge.svg?branch=master)

Optimized Smart Contract to Poke (`poke`).

For Now, Hard Coded Addresses and Sequences. Easy for TechOps to Run.

MegaPoker Current Mainnet Address: [0x1cFd93A4864bEC32C12c77594c2ec79DeeC16038](https://etherscan.io/address/0x1cFd93A4864bEC32C12c77594c2ec79DeeC16038#code)

# OmegaPoker

Extensible Poker for Goerli, Kovan and **Backup** for Mainnet.

The OmegaPoker will gather PIP Addresses from the [Ilk Registry](https://github.com/makerdao/ilk-registry) and Poke ALL Collaterals Without a Redeployment, at the expense of a little gas.

OmegaPoker Goerli Address: [0x091971A1DdDF12450D0D7003A29cD9fb94f8e54c](https://goerli.etherscan.io/address/0x091971a1dddf12450d0d7003a29cd9fb94f8e54c#code)

OmegaPoker Kovan Address: [0x7e2531587d25b9fc58aA051D0f19c0Ae809316E9](https://kovan.etherscan.io/address/0x7e2531587d25b9fc58aa051d0f19c0ae809316e9#code)

OmegaPoker Mainnet Address: [0xC848435494c548Cd4e3213A59521Cd21f74b8CF8](https://etherscan.io/address/0xC848435494c548Cd4e3213A59521Cd21f74b8CF8#code)

## `OmegaPoker.refresh()`

Public function to reset all PIPs. Call this when a new collateral is onboarded to Goerli, Kovan and **Backup** for Mainnet.

## `OmegaPoker.poke()`

Public function to poke all ilks. Call after `refresh()`
