#!/bin/bash
xhost local:root
docker run -it \
    --net host \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=unix$DISPLAY \
    virtrc/latest
