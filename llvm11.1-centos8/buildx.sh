#!/bin/bash
docker run --rm --privileged tonistiigi/binfmt:latest --install linux/arm64
docker buildx build --build-arg NJOBS=${NJOBS:-4} --platform linux/arm64 -t arm64v8/llvm11.1/centos:8 .
