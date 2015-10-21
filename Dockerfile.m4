#
# Oracle Server JRE
#

#
FROM tekii/debian:wheezy

MAINTAINER Pablo Jorge Eduardo Rodriguez <pr@tekii.com.ar>

LABEL version=__VERSION__

USER __USER__

RUN mkdir --parents __INSTALL__ && \
    apt-get --quiet=2 update && \
    apt-get --quiet=2 install --assume-yes --no-install-recommends wget && \
    echo "start downloading and decompressing __LOCATION__/__TARBALL__" && \
    wget --header "Cookie: oraclelicense=accept-securebackup-cookie" -q -O - __LOCATION__/__TARBALL__ | tar -xz --strip=1 -C __INSTALL__ && \
    echo "end downloading and decompressing." && \
    chown --recursive __USER__:__GROUP__ __INSTALL__ && \
    update-alternatives --install /usr/bin/java java __INSTALL__/bin/java 100 && \
    apt-get --quiet=2 purge --assume-yes wget && \
    apt-get --quiet=2 autoremove --assume-yes && \
    apt-get --quiet=2 clean && \
    apt-get --quiet=2 autoclean && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

ENV JAVA_HOME __INSTALL__
