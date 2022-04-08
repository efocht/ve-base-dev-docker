#!/bin/bash
#
# Add a user/group according to the CURR_{UID,GID,UNAME,GNAME} env variables
# and run the passed command as that user.
#
if [ -n "$CURR_UID" -a -n "$CURR_GID" -a -n "$CURR_UNAME" -a -n "$CURR_GNAME" -a -n "$CURR_HOME" ]; then
    if ! id -g $CURR_GID >/dev/null 2>&1 ; then
	groupadd -g $CURR_GID $CURR_GNAME
    fi
    if ! id -g $CURR_UID >/dev/null 2>&1 ; then
	[ -d "$(dirname $CURR_HOME)" ] || mkdir -p "$(dirname $CURR_HOME)"
	useradd -u $CURR_UID -g $CURR_GID -d "$CURR_HOME" -M $CURR_UNAME
    fi
    rm -f /etc/security/limits.d/10-veos.conf
    /usr/sbin/runuser -u $CURR_UNAME "$@"
else
    $@
fi
