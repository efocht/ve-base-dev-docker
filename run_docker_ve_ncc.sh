#!/bin/bash
# 
# Run docker container with a vector engine and bind-mounted
# NEC veos, libs, nlc, proprietary compilers.
#
# The current user's HOME will get mounted into the same place
# as on the host.
#
VENODEID=${VE_NODE_NUMBER:-0}
VE=$(readlink -f /dev/veslot$VENODEID)
docker run -it --rm \
    -e CURR_UNAME=$(id -un) -e CURR_GNAME=$(id -gn) \
    -e CURR_UID=$(id -u) -e CURR_GID=$(id -g) -e CURR_HOME="$HOME" \
    -v /dev:/dev:z \
    --device $VE:$VE \
    -v /var/opt/nec/ve/veos:/var/opt/nec/ve/veos:z \
    -v /opt/nec/ve/bin/ncc:/opt/nec/ve/bin/ncc:ro \
    -v /opt/nec/ve/bin/nc++:/opt/nec/ve/bin/nc++:ro \
    -v /opt/nec/ve/bin/nfort:/opt/nec/ve/bin/nfort:ro \
    -v /opt/nec/ve/include:/opt/nec/ve/include:ro \
    -v /opt/nec/ve/lib:/opt/nec/ve/lib:ro \
    -v /opt/nec/ve/ncc:/opt/nec/ve/ncc:ro \
    -v /opt/nec/ve/nfort:/opt/nec/ve/nfort:ro \
    -v /opt/nec/ve/nlc:/opt/nec/ve/nlc:ro \
    -v /opt/nec/aur_license:/opt/nec/aur_license:ro \
    -v /usr/lib64/libaurlic.so.1:/usr/lib64/libaurlic.so.1:ro \
    -v /var/opt/nec/aur_license:/var/opt/nec/aur_license:ro \
    -v $HOME:$HOME:z \
    -w $PWD \
    efocht/ve-base-dev:latest /bin/bash
