#!/bin/bash

pkill Xquartz
open -a XQuartz
sleep 5 

export PATH="/opt/X11/bin:$PATH"
xhost +localhost
sleep 1

export IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
export DISPLAY=$IP:0

xhost + $IP
sleep 1

docker run -it --rm \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $(pwd)/macros:/app/shared \
    r3broot