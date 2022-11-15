#!/usr/bin/env bash
set -e

[[ "$(cast chain --rpc-url="$ETH_RPC_URL")" == "ethlive" ]] || { echo "Please set a Mainnet ETH_RPC_URL"; exit 1; }

for ARGUMENT in "$@"
do
    KEY=$(echo "$ARGUMENT" | cut -f1 -d=)
    VALUE=$(echo "$ARGUMENT" | cut -f2 -d=)

    case "$KEY" in
            match)           MATCH="$VALUE" ;;
            match-test)      MATCH_TEST="$VALUE" ;;
            match-contract)  MATCH_CONTRACT="$VALUE" ;;
            *)
    esac
done

export DAPP_BUILD_OPTIMIZE=1
export FOUNDRY_OPTIMIZER_RUNS=1000

if [[ -z "$MATCH" && -z "$BLOCK" ]]; then
    forge test --fork-url "$ETH_RPC_URL" --force
elif [[ -n "$MATCH" ]]; then
    forge test --fork-url "$ETH_RPC_URL" --match "$MATCH" -vvv --force
elif [[ -n "$MATCH_TEST" ]]; then
    forge test --fork-url "$ETH_RPC_URL" --match-test "$MATCH_TEST" -vvv --force
else
    forge test --fork-url "$ETH_RPC_URL" --match-contract "$MATCH_CONTRACT" -vvv --force
fi
