#!/bin/bash

VENODEID=${VE_NODE_NUMBER:-0}
VE=$(readlink -f /dev/veslot$VENODEID)
docker run -it --rm \
    -v /dev:/dev:z \
    --device $VE:$VE \
    -v /var/opt/nec/ve/veos:/var/opt/nec/ve/veos:z \
    -v $HOME:$HOME:z \
    -v /etc/passwd:/etc/passwd:ro \
    -v /etc/group:/etc/group:ro \
    -u $(id -u):$(id -g) \
    -w $PWD \
    efocht/ve-base-dev:latest /bin/bash
