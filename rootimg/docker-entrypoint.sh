#!/bin/bash
source /etc/profile.d/xcat.sh
source /var/lib/asynchronous.bash

if [[ -d /tables ]]; then
    
    export XCATBYPASS=y
    restorexCATdb -p /tables
    makedhcp -n
    mknb x86_64
    
    rm -rf /tables
fi
after nc localhost 3001 \< /dev/null <<END
    nodediscoverstart node001-node999 \
                      hostiprange=10.141.0.1-10.141.200.1 \
                      bmciprange=10.148.0.1-10.148.200.1 \
                      --skipbmcsetup &
    genimage centos7-x86_64-netboot-trinity > /var/log/genimage.log 2>&1
    packimage centos7-x86_64-netboot-trinity
END
exec "$@"
