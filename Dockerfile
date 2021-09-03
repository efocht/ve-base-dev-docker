FROM            centos:8.3.2011
MAINTAINER      efocht
ADD             dnf.conf /etc/dnf
ADD             CentOS-Base.repo /etc/yum.repos.d
ADD             CentOS-Extras.repo /etc/yum.repos.d
ADD             CentOS-AppStream.repo /etc/yum.repos.d
ADD             https://www.hpc.nec/repos/TSUBASA-soft-release-2.3-1.noarch.rpm /tmp
ADD             TSUBASA-repo.repo /tmp
ADD             sxaurora.repo /tmp
ARG             RELEASE_RPM=/tmp/TSUBASA-soft-release-*.noarch.rpm

# Install GPG keys etc...
RUN             yum -y install $RELEASE_RPM ; \
                cp /tmp/*.repo /etc/yum.repos.d ; \
                rm /tmp/*.repo /tmp/*.rpm 

# Install host development packages
RUN             yum -y install \
                    binutils gcc-toolset-10 gcc-toolset-10-libstdc++-devel \
                    python39 python39-devel python39-pip \
                    bison cmake elfutils-libelf-devel git glibc \
                    libarchive libgcc libstdc++ libxml2 ncurses-devel \
                    make unzip vim wget ; \
                yum clean all ; rm -rf /var/cache/yum/* ; \
                ln -s /usr/lib64/libstdc++.so.6 /usr/lib64/libstdc++.so

# Install VE related packages
RUN             yum -y install \
                    binutils-ve glibc-ve glibc-ve-devel kheaders-ve \
                    veoffload-aveo-devel veoffload-aveorun-devel veos-devel \
                    veosinfo-devel ; \
                yum clean all ; rm -rf /var/cache/yum/*

#ENV            LOG4C_RCPATH=/etc/opt/nec/ve/veos
CMD             ["/bin/bash"]
