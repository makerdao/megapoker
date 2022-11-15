all        :; DAPP_BUILD_OPTIMIZE=1 DAPP_BUILD_OPTIMIZE_RUNS=1000 dapp --use solc:0.6.12 build
clean      :; dapp clean
test       :; ./scripts/test.sh
test-forge :; ./scripts/test-forge.sh match="$(match)" match-test="$(match-test)" match-contract="$(match-contract)"
deploy     :; make && dapp create MegaPoker
