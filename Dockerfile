FROM centos:latest
RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-2.noarch.rpm
RUN yum -y install wget python-pip drbdlinks
RUN pip install supervisor
RUN wget http://sourceforge.net/projects/xcat/files/yum/2.8/xcat-core/xCAT-core.repo -O /etc/yum.repos.d/xCAT-core.repo
RUN wget http://sourceforge.net/projects/xcat/files/yum/xcat-dep/rh7/x86_64/xCAT-dep.repo -O /etc/yum.repos.d/xCAT-dep.repo
RUN yum -y install xCAT 
RUN rndc-confgen -a
ADD dhcpd.conf /etc/dhcp/dhcpd.conf
ADD supervisord.conf /usr/etc/supervisord.conf
CMD ["/usr/bin/supervisord", "-c", "/usr/etc/supervisord.conf"]
VOLUME ["/install", "/etc", "/opt/xcat", "/var/named", "/var/lib/dhcpd", "/var/www", "/tftpboot"]
