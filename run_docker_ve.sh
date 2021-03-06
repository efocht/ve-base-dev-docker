#!/bin/bash
#
# Run docker container with a vector engine and bind-mounted
# NEC veos, libs, nlc, but no proprietary compilers.
#
VENODEID=${VE_NODE_NUMBER:-0}
VE=$(readlink -f /dev/veslot$VENODEID)
docker run -it --rm \
    -e CURR_UNAME=$(id -un) -e CURR_GNAME=$(id -gn) \
    -e CURR_UID=$(id -u) -e CURR_GID=$(id -g) -e CURR_HOME="$HOME" \
    -v /dev:/dev:z \
    --device $VE:$VE \
    -v /var/opt/nec/ve/veos:/var/opt/nec/ve/veos:z \
    -v /opt/nec/ve/include:/opt/nec/ve/include:ro \
    -v /opt/nec/ve/lib:/opt/nec/ve/lib:ro \
    -v /opt/nec/ve/nlc:/opt/nec/ve/nlc:ro \
    -v $HOME:$HOME:z \
    -w $PWD \
    efocht/ve-base-dev:latest /bin/bash
