FROM centos:latest
RUN yum -y swap -- remove systemd-container* -- install systemd systemd-libs
RUN yum -y -q install epel-release
RUN yum -y -q install wget python-pip rsyslog
RUN pip install supervisor
RUN wget http://sourceforge.net/projects/xcat/files/yum/2.8/xcat-core/xCAT-core.repo -O /etc/yum.repos.d/xCAT-core.repo
RUN wget http://sourceforge.net/projects/xcat/files/yum/xcat-dep/rh7/x86_64/xCAT-dep.repo -O /etc/yum.repos.d/xCAT-dep.repo
RUN yum -y -q install xCAT 
RUN rndc-confgen -a
RUN echo "cache-clear"
ADD supervisord.conf /usr/etc/supervisord.conf
ADD dhcpd.conf /etc/dhcp/dhcpd.conf
ADD xcat.patch /tmp/xcat.patch
RUN cat /tmp/xcat.patch | patch -p0
ADD tables /tmp/tables
# Fixme: makedhcp and mknb need a functioning network configuration. So they cannot be set inside the image.
#RUN source /etc/profile.d/xcat.sh && /opt/xcat/sbin/xcatd && /opt/xcat/sbin/restorexCATdb -p /tmp/tables && mknb x86_64 && makedhcp -n && rm /var/run/xcatd.pid
RUN source /etc/profile.d/xcat.sh && /opt/xcat/sbin/xcatd && /opt/xcat/sbin/restorexCATdb -p /tmp/tables && rm /var/run/xcatd.pid
VOLUME ["/install", "/etc", "/opt/xcat", "/var/named", "/var/lib/dhcpd", "/var/www", "/tftpboot"]
CMD ["/usr/bin/supervisord", "-c", "/usr/etc/supervisord.conf"]
