#!/bin/sh

set -eux

# Due to the fact that cargo does not disable default features when we use
# cargo build --all --no-default-features we have to explicitly iterate over
# all crates (see https://github.com/rust-lang/cargo/issues/4753 )
DIRS=`ls -d */`
TARGET="wasm32-unknown-unknown"

for dir in $DIRS; do
    if [ $dir = "target/" ]
    then
        continue
    fi
    cd $dir
    cargo build --verbose --target $TARGET --release || {
        echo $dir failed
        exit 1
    }
    cd -
done
