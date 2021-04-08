# Stage 1. Prepare builer
FROM arm64v8/ubuntu:20.04 as builder

# compile parallelism
ARG NJOBS=4

WORKDIR /root

# install dependence of gcc
RUN apt update && apt install -y \
	build-essential \
	tar \
	wget \
	git

# Install GCC
RUN wget -q http://ftp.tsukuba.wide.ad.jp/software/gcc/releases/gcc-10.2.0/gcc-10.2.0.tar.xz \
	&& tar xf gcc-10.2.0.tar.xz \
	&& cd gcc-10.2.0 \
	&& ./contrib/download_prerequisites \
	&& mkdir -p build \
	&& cd build \
	&& ../configure --prefix=/usr/local --disable-bootstrap --disable-multilib \
	&& make -j${NJOBS} \
	&& make install

# Stage 2. Produce a minimal release image with build results.
FROM arm64v8/ubuntu:20.04

# Copy build results of stage 1 to /usr/local.
COPY --from=builder /usr/local /usr/local

# Install essential libs
RUN apt update && apt install -y \
	binutils \
	binutils-aarch64-linux-gnu \
	binutils-common \
	libatomic1 \
	libbinutils \
	libc6-dev \
	libcc1-0 \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
