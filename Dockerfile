# -*- mode: dockerfile -*-
FROM llvm-base
MAINTAINER Shogo Sawai

RUN apt-get update && \
    apt-get install -y gcc g++ git libzip-dev build-essential cmake libxml2-dev libncurses5-dev doxygen swig libreadline-dev libeditline-dev libedit-dev
RUN apt-get install -y python-dev
ADD llvm /opt/source/llvm
RUN mkdir -p /opt/build/llvm && \
    cd /opt/build/llvm && \
    cmake -G "Unix Makefiles" -DLLVM_ENABLE_TERMINFO=OFF -DLLVM_TARGETS_TO_BUILD="all" -DLLVM_ENABLE_ASSERTIONS=ON -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr -DLLVM_ENABLE_CXX1Y=yes -DCLANG_BUILD_EXAMPLES=yes /opt/source/llvm && \
    make -j 8 && \
    make install && \
    cd / && \
    rm -rf /opt/build/llvm

RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang 100
RUN update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++ 100
RUN ln -sf /usr/bin/ld.lld /usr/bin/ld
