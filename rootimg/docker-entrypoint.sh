#!/bin/bash

# FIXME: we need to really determine the interface here
: ${DHCP_IF:=eth1}
: ${BOOTFILE:=pxelinux.0}

export DHCP_IF=${DHCP_IF:=eth1}
export BOOTFILE=${BOOTFILE:=pxelinux.0}

exec "$@"
