#!/usr/bin/env bash

set -e

generic-parachain/target/release/generic-parachain-collator export-genesis-state --parachain-id=100 gc_gs
subdex-parachain/target/release/subdex-parachain-collator export-genesis-state --parachain-id=200 dc_gs

cd ./docker/register
yarn 
cd ..

node ./docker/register \
    127.0.0.1 6644 \
    ../generic-parachain/target/release/wbuild/parachain-runtime/parachain_runtime.compact.wasm \
    ../gc_gs \
    100

node ./docker/register \
    127.0.0.1 6644 \
    ../subdex-parachain/target/release/wbuild/parachain-runtime/parachain_runtime.compact.wasm \
    ../dc_gs \
    200
