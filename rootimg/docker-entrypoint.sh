#!/bin/bash
source /etc/profile.d/xcat.sh

if [[ -d /tables ]]; then
    
    export XCATBYPASS=y
    restorexCATdb -p /tables
    makedhcp -n
    mknb x86_64
fi
exec "$@"
