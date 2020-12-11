all    :; SOLC_FLAGS="--optimize --optimize-runs 1000" dapp --use solc:0.6.11 build
clean  :; dapp clean
test   :; ./test.sh
deploy :; dapp create MegaPoker
