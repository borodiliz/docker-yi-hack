FROM i386/ubuntu:19.10

MAINTAINER Borja Rodríguez Diliz <borja.rodriguez.diliz@gmail.com>

################# Install packages ################

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -qq install -y software-properties-common \
        language-pack-en-base sudo supervisor git build-essential unzip p7zip-full mtd-tools binwalk \
        rsync autoconf bison flex yui-compressor libxml2-utils

################# Install packages ################

COPY files/root /

################ Section SSH ################
RUN apt-get update && \
    apt-get install -y openssh-server && \
    mkdir /var/run/sshd && \
    echo 'root:root' | chpasswd && \
    sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"

RUN echo "export VISIBLE=now" >> /etc/profile
################ End SSH ################

################ Section cross-compiling ################
RUN tar xfvz /opt/yi/arm-linux-gnueabihf-4.8.3-201404.tar.gz -C /opt/yi/
################ End cross-compiling ################

################ Section jefferson ################
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -qq install -y python-pip python-lzma
RUN pip install cstruct && cd /tmp/ && git clone https://github.com/sviehb/jefferson && (cd jefferson && sudo python setup.py install)
################ End jefferson ################

ENV TERM xterm
ENV ON_ENTRY_SCRIPT=$ON_ENTRY_SCRIPT

RUN mkdir -p /root/.ssh/ /yi-hack-src/

VOLUME  ["/yi-hack-src"]
VOLUME  ["/root/.ssh/"]

EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]
