FROM ubuntu:latest
MAINTAINER Milo Kim <woogyom.kim@gmail.com>

RUN apt-get update

# Install web browser, QEMU to run virt-rc
RUN apt-get install -y wget xdg-utils midori \
libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev \
libaio-dev libbluetooth-dev libbrlapi-dev libbz2-dev \
libcap-dev libcap-ng-dev libcurl4-gnutls-dev libgtk-3-dev \
libibverbs-dev libjpeg8-dev libncurses5-dev libnuma-dev \
librbd-dev librdmacm-dev \
libsasl2-dev libsdl1.2-dev libseccomp-dev libsnappy-dev libssh2-1-dev \
libvde-dev libvdeplug-dev libvte-2.90-dev libxen-dev liblzo2-dev \
valgrind xfslibs-dev

ENV home /home/virtrc
RUN mkdir -p ${home}
WORKDIR ${home}

# Download QEMU and kernel image for virt-rc
RUN wget https://s3.amazonaws.com/virt-rc/run_virtrc.sh
RUN wget https://s3.amazonaws.com/virt-rc/qemu-system-aarch64
RUN wget https://s3.amazonaws.com/virt-rc/Image
RUN chmod a+x *
