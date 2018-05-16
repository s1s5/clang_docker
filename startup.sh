#!/bin/bash
# -*- mode: shell-script -*-

set -eu  # <= 0以外が返るものがあったら止まる, 未定義の変数を使おうとしたときに打ち止め

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

export LLVM_HASH=$1
export LLVM_LLD_HASH=${LLVM_LLD_HASH:-${LLVM_HASH}}
export LLVM_LLDB_HASH=${LLVM_LLDB_HASH:-${LLVM_HASH}}
export LLVM_POLLY_HASH=${LLVM_POLLY_HASH:-${LLVM_HASH}}
export LLVM_LLGO_HASH=${LLVM_LLGO_HASH:-${LLVM_HASH}}
export CLANG_HASH=${CLANG_HASH:-${LLVM_HASH}}
export COMPILER_RT_HASH=${COMPILER_RT_HASH:-${LLVM_HASH}}
export LIBCXX_HASH=${LIBCXX_HASH:-${LLVM_HASH}}
export LIBCXXABI_HASH=${LIBCXXABI_HASH:-${LLVM_HASH}}
export OPENMP_HASH=${OPENMP_HASH:-${LLVM_HASH}}
export CLANG_TOOLS_EXTRA_HASH=${CLANG_TOOLS_EXTRA_HASH:-${LLVM_HASH}}

echo "================================================================================"
echo "checking llvm"
echo "------------------------------------------------------------"
if [ ! -e llvm ]; then
    git clone -n http://llvm.org/git/llvm.git
fi
cd ${SCRIPT_DIR}/llvm
git checkout ${LLVM_HASH}
if [[ ${LLVM_HASH} == release_* ]]; then
    git fetch
    git merge origin/${LLVM_HASH}
fi

echo "================================================================================"
echo "checking llvm/tools"
echo "------------------------------------------------------------"
echo "checking llvm/tools/lld"
echo "----------------------------------------"
cd ${SCRIPT_DIR}/llvm/tools
if [ ! -e lld ]; then
    git clone -n https://github.com/llvm-mirror/lld.git
fi

cd ${SCRIPT_DIR}/llvm/tools/lld/
git checkout ${LLVM_LLD_HASH}
if [[ ${LLVM_LLD_HASH} == release_* ]]; then
    git fetch
    git merge origin/${LLVM_LLD_HASH}
fi

echo "------------------------------------------------------------"
echo "checking llvm/tools/lldb"
echo "----------------------------------------"
cd ${SCRIPT_DIR}/llvm/tools
if [ ! -e lldb ]; then
    git clone -n https://github.com/llvm-mirror/lldb.git
fi

cd ${SCRIPT_DIR}/llvm/tools/lldb/
git checkout ${LLVM_LLDB_HASH}
if [[ ${LLVM_LLDB_HASH} == release_* ]]; then
    git fetch
    git merge origin/${LLVM_LLDB_HASH}
fi

echo "------------------------------------------------------------"
echo "checking llvm/tools/polly"
echo "----------------------------------------"
cd ${SCRIPT_DIR}/llvm/tools
if [ ! -e polly ]; then
    git clone -n https://github.com/llvm-mirror/polly.git
fi

cd ${SCRIPT_DIR}/llvm/tools/polly/
git checkout ${LLVM_POLLY_HASH}
if [[ ${LLVM_POLLY_HASH} == release_* ]]; then
    git fetch
    git merge origin/${LLVM_POLLY_HASH}
fi

# echo "------------------------------------------------------------"
# echo "checking llvm/tools/llgo"
# cd ${SCRIPT_DIR}/llvm/tools
# if [ ! -e llgo ]; then
#     git clone -n https://github.com/llvm-mirror/llgo.git
# fi
# 
# cd ${SCRIPT_DIR}/llvm/tools/llgo/
# git checkout ${LLVM_LLGO_HASH}
# if [[ ${LLVM_LLGO_HASH} == release_* ]]; then
#     git fetch
#     git merge origin/${LLVM_LLGO_HASH}
# fi

echo "------------------------------------------------------------"
echo "checking llvm/tools/clang"
echo "----------------------------------------"
cd ${SCRIPT_DIR}/llvm/tools
if [ ! -e clang ]; then
    git clone -n http://llvm.org/git/clang.git
fi

cd ${SCRIPT_DIR}/llvm/tools/clang/
git checkout ${CLANG_HASH}
if [[ ${CLANG_HASH} == release_* ]]; then
    git fetch
    git merge origin/${CLANG_HASH}
fi

echo "================================================================================"
echo "checking llvm/projects/"
echo "------------------------------------------------------------"
echo "checking llvm/projects/compiler-rt"
echo "----------------------------------------"
cd ${SCRIPT_DIR}/llvm/projects/
if [ ! -e compiler-rt ]; then
    git clone -n http://llvm.org/git/compiler-rt.git
fi

cd ${SCRIPT_DIR}/llvm/projects/compiler-rt
git checkout ${COMPILER_RT_HASH}
if [[ ${COMPILER_RT_HASH} == release_* ]]; then
    git fetch
    git merge origin/${COMPILER_RT_HASH}
fi

echo "------------------------------------------------------------"
echo "checking llvm/projects/libcxx"
echo "----------------------------------------"
cd ${SCRIPT_DIR}/llvm/projects/
if [ ! -e libcxx ]; then
    git clone -n http://llvm.org/git/libcxx.git
fi

cd ${SCRIPT_DIR}/llvm/projects/libcxx
git checkout ${LIBCXX_HASH}
if [[ ${LIBCXX_HASH} == release_* ]]; then
    git fetch
    git merge origin/${LIBCXX_HASH}
fi

echo "------------------------------------------------------------"
echo "checking llvm/projects/libcxxabi"
echo "----------------------------------------"
cd ${SCRIPT_DIR}/llvm/projects/
if [ ! -e libcxxabi ]; then
    git clone -n http://llvm.org/git/libcxxabi.git
fi

cd ${SCRIPT_DIR}/llvm/projects/libcxxabi
git checkout ${LIBCXXABI_HASH}
if [[ ${LIBCXXABI_HASH} == release_* ]]; then
    git fetch
    git merge origin/${LIBCXXABI_HASH}
fi

echo "------------------------------------------------------------"
echo "checking llvm/projects/openmp"
echo "----------------------------------------"
cd ${SCRIPT_DIR}/llvm/projects/
if [ ! -e openmp ]; then
    git clone -n http://llvm.org/git/openmp.git
fi

cd ${SCRIPT_DIR}/llvm/projects/openmp
git checkout ${OPENMP_HASH}
if [[ ${OPENMP_HASH} == release_* ]]; then
    git fetch
    git merge origin/${OPENMP_HASH}
fi

echo "------------------------------------------------------------"
echo "checking llvm/tools/clang/tools"
echo "----------------------------------------"
cd ${SCRIPT_DIR}/llvm/tools/clang/tools/
if [ ! -e clang-tools-extra ]; then
    git clone -n http://llvm.org/git/clang-tools-extra.git
fi

echo "------------------------------------------------------------"
echo "checking llvm/tools/clang/tools/clang-tools-extra"
echo "----------------------------------------"
cd ${SCRIPT_DIR}/llvm/tools/clang/tools/clang-tools-extra
git checkout ${CLANG_TOOLS_EXTRA_HASH}
if [[ ${CLANG_TOOLS_EXTRA_HASH} == release_* ]]; then
    git fetch
    git merge origin/${CLANG_TOOLS_EXTRA_HASH}
fi
