FROM centos:latest
RUN yum -y -q install epel-release
RUN yum -y -q install wget python-pip rsyslog
RUN pip install supervisor
RUN wget https://xcat.org/files/xcat/repos/yum/2.12/xcat-core/xCAT-core.repo -O /etc/yum.repos.d/xCAT-core.repo
RUN wget https://xcat.org/files/xcat/repos/yum/xcat-dep/rh7/x86_64/xCAT-dep.repo -O /etc/yum.repos.d/xCAT-dep.repo
RUN yum -y -q install xCAT 
RUN rndc-confgen -a
ADD supervisord.conf /usr/etc/supervisord.conf
ADD rootimg /
ADD tables /tables
RUN XCATROOT=/opt/xcat PATH=$XCATROOT/bin:$XCATROOT/sbin:$XCATROOT/share/xcat/tools:$PATH  XCATBYPASS=y restorexCATdb -p /tables
RUN XCATROOT=/opt/xcat PATH=$XCATROOT/bin:$XCATROOT/sbin:$XCATROOT/share/xcat/tools:$PATH  XCATBYPASS=y makedhcp -n
RUN rm -rf /tables
VOLUME ["/install", "/etc", "/opt/xcat", "/var/named", "/var/lib/dhcpd", "/var/www", "/tftpboot"]
CMD ["/usr/bin/supervisord", "-c", "/usr/etc/supervisord.conf"]
ENTRYPOINT ["/docker-entrypoint.sh"]
