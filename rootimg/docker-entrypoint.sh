#!/bin/bash
source /etc/profile.d/xcat.sh

if [[ -d /tables ]]; then
    
    export XCATBYPASS=y
    restorexCATdb -p /tables
    makedhcp -n
    mknb x86_64
    
    rm -rf /tables
    mknod /dev/loop2 -m0660 b 7 2
    copycds -o -n centos7 /sync/*/*.iso
fi
exec "$@"
