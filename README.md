# MegaPoker
![Build Status](https://github.com/makerdao/megapoker/actions/workflows/.github/workflows/tests.yaml/badge.svg?branch=master)

Optimized Smart Contract to Poke (`poke`).

For Now, Hard Coded Addresses and Sequences. Easy for TechOps to Run.

MegaPoker current Mainnet Address: [0xea347db6ef446e03745c441c17018ef3d641bc8f](https://etherscan.io/address/0xea347db6ef446e03745c441c17018ef3d641bc8f#code)

# OmegaPoker

Extensible Poker for Goerli, Kovan and **Backup** for Mainnet.

The OmegaPoker will gather PIP Addresses from the [Ilk Registry](https://github.com/makerdao/ilk-registry) and Poke ALL Collaterals Without a Redeployment, at the expense of a little gas.

OmegaPoker Goerli Address: [0x091971A1DdDF12450D0D7003A29cD9fb94f8e54c](https://goerli.etherscan.io/address/0x091971a1dddf12450d0d7003a29cd9fb94f8e54c#code)

OmegaPoker Kovan Address: [0xB73c7D82956C9DFd17F8D212b9Cc9062ac04799e](https://kovan.etherscan.io/address/0xB73c7D82956C9DFd17F8D212b9Cc9062ac04799e#code)

OmegaPoker Mainnet Address: [0xAD0c5607d62b4003D70A5eA55893E23d7E2D3f0C](https://etherscan.io/address/0xAD0c5607d62b4003D70A5eA55893E23d7E2D3f0C#code)

## `OmegaPoker.refresh()`

Public function to reset all PIPs. Call this when a new collateral is onboarded to Goerli, Kovan and **Backup** for Mainnet.

## `OmegaPoker.poke()`

Public function to poke all ilks. Call after `refresh()`
