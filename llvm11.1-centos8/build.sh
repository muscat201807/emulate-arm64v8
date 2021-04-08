#!/bin/bash
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
docker build --build-arg NJOBS=${NJOBS:-4} -t arm64v8/llvm11.1/centos:8 .
