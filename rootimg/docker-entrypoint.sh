#!/bin/bash
source /etc/profile.d/xcat.sh

if [[ -d /tables ]]; then
    restorexCATdb -p /tables
    makedhcp -n
fi
exec "$@"
