#!/bin/bash

cd $(dirname $0)

docker build --build-arg DEDROID=fopina/dedroid:test -t fopina/dedroid:test .