# PXE: a simple PXE server

This is an effort to demostrate how simple it can be to build a simple
PXE server inside a Docker container. It is used to quickly deploy
HPC test clusters for HPC Swarm.

The PXE server consists of a few pre-defined components:
1. a DHCP server, which was reused from David Andersons code in ptftpd.
2. a tftp server, for which I used the atftp server.

## Usage

To use PXE, simply start the container as follows:

    docker run -d --volumes=/tftpboot:/tftpboot --name=pxe --net=host pythea/pxe

The container will serve any pxelinux.0 found in /tftpboot.

Alternatively, for demonstration purposes, I have shamelessly stolen a 
a small image container. This will show how to setup a new image in a 
container and attach it to the PXE server.

    docker run -d --env=BOOTFILE=/debian/wheezy/amd64/install/pxelinux.0 \ 
    --volumes-from=pxe-images --name=pxe --net=host pythea/pxe

To listen on a different interface, supply the DHCP_IF environment variable.
Please note that the DHCP server will use the first address on the specified
interface to determine the range of available addresses.

## Design Rationale

I used the python dhcp server over David Andersons other PXE server 
[pixiecore](https://github.com/danderson/pixiecore), which is also 
packaged as a container. Although I like the API mode, that container
does not serve as an independent DHCP server and requires a separate
DHCP server on the same network.

I used the existing atftp server because it supports 
[RFC2090 TFTP Multicast Option](https://tools.ietf.org/html/rfc2090).

For a similar reason, I did not use J. Pettazoni's 
[pxe](https://github.com/jpetazzo/pxe), although I used his code to
create the debian images.

#Acknowledgements
D. Anderson for ptftpd and pixiecore.
M. Pettazoni for ptftpd.
J. Pettazoni for pxe.
