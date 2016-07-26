FROM centos:latest

RUN yum -y -q update && yum -y -q install epel-release && \
    yum -y -q install wget python-pip gcc python-devel && \
    pip install supervisor ptftpd && \
    yum -y -q install https://repoforge.cu.be/redhat/el7/en/x86_64/dag/RPMS/atftp-server-0.7-6.el7.rf.x86_64.rpm && \
    yum -y -q remove gcc python-devel && \
    yum -y -q clean all

VOLUME ["/tftpboot"]
ADD rootimg /
ADD supervisord.conf /usr/etc
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-c", "/usr/etc/supervisord.conf"]

