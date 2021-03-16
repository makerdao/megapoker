all    :; SOLC_FLAGS="--optimize --optimize-runs 1000" dapp --use solc:0.6.12 build
clean  :; dapp clean
test   :; ./test.sh
deploy :; make && dapp create MegaPoker
