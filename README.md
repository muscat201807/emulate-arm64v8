# Emulate Arm64 + SVE environment on docker

## What is this ?

`Dockerfile`s and build scripts to setup Arm64 + [SVE](https://developer.arm.com/documentation/101726/0300/Learn-about-the-Scalable-Vector-Extension--SVE-/What-is-the-Scalable-Vector-Extension-) environment,

## How to use

```sh
git clone https://github.com/muscat201807/emulate-arm64v8.git
```
> NOTE : Building may takes a lot of time (6H~1day with NJOBS=4). **It is recommended to set `NJOBS` to about half the number of cores.**

### Use docker buildx

- Ubuntu:20.04 + GCC10.2

```sh
cd gcc10.2-ubuntu20.04
NJOBS=4 ./buildx.sh
```

- CentOS:8 + LLVM11.1

```sh
cd llvm11.1-centos8
NJOBS=4 ./buildx.sh
```

### Don't use docker buildx

- Ubuntu:20.04 + GCC10.2

```sh
cd gcc10.2-ubuntu20.04
NJOBS=4 ./build.sh
```

- CentOS:8 + LLVM11.1

```sh
cd llvm11.1-centos8
NJOBS=4 ./build.sh
```

## Run & Check

```sh
docker run -it --rm arm64v8/gcc10.2/ubuntu:20.04 arch

# aarch64

docker run -it --rm arm64v8/gcc10.2/ubuntu:20.04 sh -c 'gcc -march=native -dM -E - < /dev/null' | grep SVE

# #define __SVE__ 1
```
