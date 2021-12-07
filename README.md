# MegaPoker
![Build Status](https://github.com/makerdao/megapoker/actions/workflows/.github/workflows/tests.yaml/badge.svg?branch=master)

Optimized Smart Contract to Poke (`poke`).

For Now, Hard Coded Addresses and Sequences. Easy for TechOps to Run.

MegaPoker curent Mainnet Address: [0x63d2ACa166420C9d6a08718477D1b3D403d0085C](https://etherscan.io/address/0x63d2ACa166420C9d6a08718477D1b3D403d0085C#code)

# OmegaPoker

Extensible Poker for Goerli, Kovan and **Backup** for Mainnet.

The OmegaPoker will gather PIP Addresses from the [Ilk Registry](https://github.com/makerdao/ilk-registry) and Poke ALL Collaterals Without a Redeployment, at the expense of a little gas.

OmegaPoker Goerli Address: [0x091971A1DdDF12450D0D7003A29cD9fb94f8e54c](https://goerli.etherscan.io/address/0x091971a1dddf12450d0d7003a29cd9fb94f8e54c#code)

OmegaPoker Kovan Address: [0xB73c7D82956C9DFd17F8D212b9Cc9062ac04799e](https://kovan.etherscan.io/address/0xB73c7D82956C9DFd17F8D212b9Cc9062ac04799e#code)

OmegaPoker Mainnet Address: [0xC848435494c548Cd4e3213A59521Cd21f74b8CF8](https://etherscan.io/address/0xC848435494c548Cd4e3213A59521Cd21f74b8CF8#code)

## `OmegaPoker.refresh()`

Public function to reset all PIPs. Call this when a new collateral is onboarded to Goerli, Kovan and **Backup** for Mainnet.

## `OmegaPoker.poke()`

Public function to poke all ilks. Call after `refresh()`
