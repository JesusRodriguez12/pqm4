#!/bin/bash

python3 -mvenv venv
source venv/bin/activate
pip install ninja meson pyserial chipwhisperer

set -x

BASEDIR=$(dirname "$0")

QEMU_VERSION="7.0.0"

Download requirements
wget -c "https://developer.arm.com/-/media/Files/downloads/gnu/11.2-2022.02/binrel/gcc-arm-11.2-2022.02-x86_64-arm-none-eabi.tar.xz"
wget -c "https://download.qemu.org/qemu-7.0.0.tar.bz2"

mkdir -p ${BASEDIR}/venv/src
tar --strip-components=1 -C ${BASEDIR}/venv -xf gcc-arm-11.2-2022.02-x86_64-arm-none-eabi.tar.xz
tar -C ${BASEDIR}/venv/src -xf qemu-${QEMU_VERSION}.tar.bz2

QEMU_PREFIX=$(realpath ${BASEDIR}/venv)

cd venv/src/qemu-${QEMU_VERSION}
./configure --prefix=${QEMU_PREFIX} \
    --target-list=arm-softmmu \
    --disable-alsa \
    --disable-alsa \
    --disable-attr \
    --disable-auth-pam \
    --disable-bpf \
    --disable-brlapi \
    --disable-bzip2 \
    --disable-cap-ng \
    --disable-cocoa \
    --disable-coreaudio \
    --disable-curl \
    --disable-docs \
    --disable-dsound \
    --disable-fuse \
    --disable-fuse-lseek \
    --disable-gcrypt \
    --disable-glusterfs \
    --disable-gnutls \
    --disable-gtk \
    --disable-guest-agent-msi \
    --disable-hax \
    --disable-hvf \
    --disable-iconv \
    --disable-jack \
    --disable-kvm \
    --disable-l2tpv3 \
    --disable-libdaxctl \
    --disable-libiscsi \
    --disable-libnfs \
    --disable-libpmem \
    --disable-libssh \
    --disable-libudev \
    --disable-libusb \
    --disable-linux-aio \
    --disable-linux-io-uring \
    --disable-lzfse \
    --disable-lzo \
    --disable-multiprocess \
    --disable-netmap \
    --disable-nettle \
    --disable-nvmm \
    --disable-oss \
    --disable-pa \
    --disable-rbd \
    --disable-sdl \
    --disable-sdl-image \
    --disable-selinux \
    --disable-smartcard \
    --disable-snappy \
    --disable-sparse \
    --disable-spice \
    --disable-spice-protocol \
    --disable-u2f \
    --disable-usb-redir \
    --disable-vde \
    --disable-vhost-user-blk-server \
    --disable-virglrenderer \
    --disable-virtfs \
    --disable-virtiofsd \
    --disable-vnc \
    --disable-vnc-jpeg \
    --disable-vnc-png \
    --disable-vnc-sasl \
    --disable-vte \
    --disable-whpx \
    --disable-xen \
    --disable-xen-pci-passthrough \
    --disable-xkbcommon \
    --disable-zstd \
    --disable-guest-agent \
    --disable-rdma \
    --disable-pvrdma \
    --disable-vhost-net \
    --disable-vhost-vsock \
    --disable-vhost-scsi \
    --disable-vhost-crypto \
    --disable-vhost-kernel \
    --disable-vhost-user \
    --disable-vhost-vdpa \
    --disable-live-block-migration \
    --disable-coroutine-pool \
    --disable-tpm \
    --disable-numa \
    --disable-avx2 \
    --disable-avx512f \
    --disable-replication \
    --disable-opengl \
    --disable-qom-cast-debug \
    --disable-tools \
    --disable-bochs \
    --disable-cloop \
    --disable-dmg \
    --disable-qcow1 \
    --disable-vdi \
    --disable-vvfat \
    --disable-qed \
    --disable-parallels \
    --disable-crypto-afalg \
    --disable-debug-mutex \
    --disable-rng-none \
    --disable-gio \
    --disable-slirp-smbd
make
make install

