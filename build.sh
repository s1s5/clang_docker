#!/bin/bash
# -*- mode: shell-script -*-

set -eu  # <= 0以外が返るものがあったら止まる, 未定義の変数を使おうとしたときに打ち止め
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

export RELEASE=${1:-50}

pushd `pwd`
cd ${SCRIPT_DIR}

# ./startup.sh release_${RELEASE}
docker pull ubuntu:18.04
docker tag ubuntu:18.04 llvm-base
docker build . -t llvm:${RELEASE}
docker tag llvm:${RELEASE} s1s5/llvm:${RELEASE}
docker push s1s5/llvm:${RELEASE}
popd
