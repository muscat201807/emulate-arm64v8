#!/bin/bash
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
docker build --build-arg NJOBS=${NJOBS:-4} -t arm64v8/gcc10.2/ubuntu:20.04 .
