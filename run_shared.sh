#!/bin/bash

docker run -it --rm \
    -v $(pwd)/macros:/app/shared \
    r3broot