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
VOLUME ["/install", "/etc", "/opt/xcat", "/var/named", "/var/lib/dhcpd", "/var/www", "/tftpboot"]
CMD ["/usr/bin/supervisord", "-c", "/usr/etc/supervisord.conf"]
ENTRYPOINT ["/docker-entrypoint.sh"]
RUN yum -y -q install git
RUN git clone --depth=1 http://github.com/hansthen/salvage
RUN cp -LrT salvage/controller/rootimg /
ADD https://raw.githubusercontent.com/hansthen/asynchronous.bash/master/asynchronous.bash /var/lib/asynchronous.bash
RUN yum -y remove tftp-server-5.2-12.el7.x86_64
RUN yum -y install https://repoforge.cu.be/redhat/el7/en/x86_64/dag/RPMS/atftp-server-0.7-6.el7.rf.x86_64.rpm
RUN yum -y install xCAT

