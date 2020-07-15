FROM centos:8 AS build

run dnf install -y \
        gcc \
        make \
        openssl-devel \
        autoconf \
        libcurl-devel \
        expat-devel  \
        gettext-devel

run set -xe; \
    cd /tmp; \
    curl -L -o git.tgz https://github.com/git/git/archive/v2.27.0.tar.gz; \
    tar xf git.tgz; \
    cd git-2.27.0; \
    make configure; \
    ./configure --prefix=/opt/git; \
    make all; \
    make install

FROM centos:8

copy --from=build /opt/git /opt/git
env PATH=/opt/git/bin:$PATH
