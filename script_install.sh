#!/bin/bash
#qemu-img create -f qcow2 ./centos6.qcow2 8G
# need packets: cpio cdrtools
# chown iso-file for user:user

if [ "${1:-0}" = clear ]; then
	sudo virsh destroy test_centos6
	sudo virsh undefine test_centos6
	sudo rm -vf /var/lib/libvirt/images/test_centos6*
	exit 0
fi

#mount -o loop "$HOME"/reps/auto_create_virt/CentOS-6.10-x86_64-minimal.iso /mnt/cdrom

sudo virt-install --debug \
	--connect=qemu:///system \
	--virt-type=qemu \
	--network default \
	--name=test_centos6 \
	--memory 1024 \
	--vcpus 1 \
	--accelerate \
	--hvm \
	--os-variant centos6.9 \
	--arch x86_64 \
	--graphics none \
	--os-type linux \
	--network bridge=virbr0 \
	--console pty,target_type=serial \
	--disk /var/lib/libvirt/images/centos6.qcow2,device=disk,bus=virtio,size=8 \
	--initrd-inject=ks.cfg \
	--location /var/lib/libvirt/images/CentOS-6.10-x86_64-minimal.iso \
	--initrd-inject 'ks.cfg' \
	--extra-args 'ks=file:/ks.cfg console=tty0 console=ttyS0,115200n8'
#	--disk size=8,format=qcow2 \
#	--graphics vnc,port=5999 \
#	--initrd-inject=/"$HOME"/reps/auto_create_virt/ks.cfg \
#--location 'http://mirror.i3d.net/pub/centos/6/os/x86_64/' \
#	--location '/mnt/cdrom/' \
#--cdrom CentOS-6.10-x86_64-minimal.iso \
#--extra-args 'console=ttyS0,115200n8 serial'
#--extra-args='ks=file:/ks.cfg console=tty0 console=ttyS0,115200n8 serial' \
