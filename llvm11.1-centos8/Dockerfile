# Stage 1. Check out LLVM source code and run the build.
FROM arm64v8/centos:8 as builder

# compile parallelism
ARG NJOBS=4

WORKDIR /root

# Install build dependencies of llvm.
RUN dnf update -y && dnf install -y \
	bzip2 \
	which \
	wget \
	git \
	zip \
	unzip \
	zlib \
	zlib-devel \
	python3 \
	openssl \
	openssl-devel \
	&& dnf groupinstall -y "Development Tools"

# Install cmake
RUN wget -q https://github.com/Kitware/CMake/releases/download/v3.20.0/cmake-3.20.0.tar.gz \
	&& tar zxf cmake-3.20.0.tar.gz \
	&& cd cmake-3.20.0 \
	&& ./configure --prefix=/usr/local \
	&& make -j${NJOBS} \
	&& make install

# Install Ninja
RUN wget -q https://github.com/ninja-build/ninja/archive/refs/tags/v1.10.2.tar.gz \
	&& tar zxf v1.10.2.tar.gz \
	&& cd ninja-1.10.2/ \
	&& cmake -Bbuild-cmake -H. \
	&& cmake --build build-cmake --parallel ${NJOBS} \
	&& cp build-cmake/ninja /usr/local/bin/

# Install LLVM
RUN wget -q https://github.com/llvm/llvm-project/archive/refs/tags/llvmorg-11.1.0.tar.gz \
	&& tar zxf llvmorg-11.1.0.tar.gz \
	&& cd llvm-project-llvmorg-11.1.0/ \
	&& mkdir build \
	&& cd build \
	&& cmake -GNinja \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX=/usr/local \
	-DLLVM_ENABLE_PROJECTS='clang;clang-tools-extra;libcxx;libcxxabi;libunwind;lldb;compiler-rt;lld;polly;openmp;parallel-libs;mlir;flang;debuginfo-tests' \
	../llvm \
	&& cmake --build . --parallel ${NJOBS} \
	&& cmake --install .

# Stage 2. Produce a minimal release image with build results.
FROM arm64v8/centos:8

# Copy build results of stage 1 to /usr/local.
COPY --from=builder /usr/local /usr/local

# Install essential libs
RUN dnf update -y && dnf install -y \
	glibc-devel \
	glibc-headers \
	gcc \
	gcc-c++ \
	&& dnf clean all
