FROM centos:latest
RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-2.noarch.rpm
RUN yum -y install wget python-pip
RUN pip install supervisor
RUN wget http://sourceforge.net/projects/xcat/files/yum/2.8/xcat-core/xCAT-core.repo -O /etc/yum.repos.d/xCAT-core.repo
RUN wget http://sourceforge.net/projects/xcat/files/yum/xcat-dep/rh7/x86_64/xCAT-dep.repo -O /etc/yum.repos.d/xCAT-dep.repo
RUN yum -y install xCAT 
ADD dhcpd.conf /etc/dhcp/dhcpd.conf
ADD supervisord.conf /usr/etc/supervisord.conf
CMD ["/usr/bin/supervisord", "-c", "/usr/etc/supervisord.conf"]
VOLUME ["/install", "/etc/xcat", "/opt/xcat", "/root/.xcat", "/etc/hosts", "/etc/conserver.cf"]
VOLUME ["/tftpboot"]
VOLUME ["/etc/named", "/etc/named.conf", "/etc/named.iscdlv.key", "/etc/named.rfc1912.zones", "/etc/named.root.key", "/etc/rndc.conf", "/etc/rndc.key", "/etc/sysconfig/named", "/var/named"]
VOLUME ["/etc/dhcp", "/var/lib/dhcpd", "/etc/sysconfig/dhcpd", "/etc/sysconfig/dhcpd6"]
VOLUME ["/etc/httpd", "/var/www"]
