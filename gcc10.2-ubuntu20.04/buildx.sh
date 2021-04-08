#!/bin/bash
docker run --rm --privileged tonistiigi/binfmt:latest --install linux/arm64
docker buildx build --build-arg NJOBS=${NJOBS:-4} --platform linux/arm64 -t arm64v8/gcc10.2/ubuntu:20.04 .
