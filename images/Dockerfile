FROM centos:latest

RUN yum -y -q update && \
    yum -y -q install wget && \
    yum -y -q clean all

ENV ARCH amd64
ENV DIST wheezy
ENV MIRROR http://ftp.nl.debian.org

RUN mkdir -p /tftpboot/debian/$DIST/$ARCH/install/
WORKDIR /tftpboot/debian/$DIST/$ARCH/install/
RUN wget $MIRROR/debian/dists/$DIST/main/installer-$ARCH/current/images/netboot/debian-installer/$ARCH/linux
RUN wget $MIRROR/debian/dists/$DIST/main/installer-$ARCH/current/images/netboot/debian-installer/$ARCH/initrd.gz
RUN wget $MIRROR/debian/dists/$DIST/main/installer-$ARCH/current/images/netboot/debian-installer/$ARCH/pxelinux.0
RUN mkdir pxelinux.cfg
RUN printf "DEFAULT linux\nLABEL linux\nKERNEL linux\nAPPEND initrd=initrd.gz\n" >pxelinux.cfg/default

VOLUME ["/tftpboot/debian/$DIST/$ARCH/install"]

