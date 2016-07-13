FROM centos:latest
RUN yum -y -q install epel-release
RUN yum -y -q install wget python-pip fuseiso createrepo
RUN wget https://xcat.org/files/xcat/repos/yum/2.12/xcat-core/xCAT-core.repo -O /etc/yum.repos.d/xCAT-core.repo
RUN wget https://xcat.org/files/xcat/repos/yum/xcat-dep/rh7/x86_64/xCAT-dep.repo -O /etc/yum.repos.d/xCAT-dep.repo
RUN wget http://linux.cs.uu.nl/centos/7/isos/x86_64/CentOS-7-x86_64-DVD-1511.iso
RUN yum -y -q install p7zip p7zip-plugins git
RUN mkdir -p /install/centos7/x86_64/;\
    mkdir mount;\
    7z x CentOS-7-x86_64-*-1511.iso -o/install/centos7/x86_64;\
    createrepo /install/centos7/x86_64
RUN ls /install/centos7/x86_64

ENTRYPOINT ["/docker-entrypoint.sh"]
RUN git clone --depth=1 http://github.com/hansthen/salvage/ 
RUN mkdir -p /install/post/otherpkgs/centos7/x86_64/Packages
RUN cat salvage/controller/rootimg/install/custom/install/centos/*pkg* \
        salvage/controller/rootimg/install/custom/netboot/centos/*pkg* \
        | grep -v ^# | grep -v ^$ | grep -v ^@ | sort -u | \
        xargs repotrack -p /install/post/otherpkgs/centos7/x86_64/Packages ;\
RUN cat salvage/controller/rootimg/install/custom/install/centos/*pkg* \
        salvage/controller/rootimg/install/custom/netboot/centos/*pkg* \
        | grep ^@ | sort -u | sed 's,@ ,@,' | \
        xargs yumdownloader --resolve --destdir /install/post/otherpkgs/centos7/x86_64/Packages
RUN reposync -n -r updates -p /install/post/otherpkgs/centos7/x86_64/Packages
RUN createrepo /install/post/otherpkgs/centos7/x86_64/
RUN cp -LrT salvage/controller/rootimg /
VOLUME "/install/centos7" "/install/post"
