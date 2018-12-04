#!/bin/bash
#qemu-img create -f qcow2 ./centos6.qcow2 8G

virt-install \
	--connect=qemu:///system \
	--virt-type=qemu \
	--network default \
	--name=test_centos6 \
	--disk size=8,format=qcow2 \
	--memory 1024 \
	--vcpus 1 \
	--os-variant centos6.9 \
	--arch x86_64 \
	--accelerate \
	--graphics none \
	--os-type linux \
	--network bridge=virbr0 \
	--graphics vnc,port=5999 \
	--console pty,target_type=serial \
	--location 'http://mirror.i3d.net/pub/centos/6/os/x86_64/' \
	--extra-args 'console=ttyS0,115200n8 serial'
#--cdrom CentOS-6.10-x86_64-minimal.iso \
#--initrd-inject=./ks.cfg \
#--extra-args 'console=ttyS0,115200n8 serial'
#--extra-args='ks=file:/ks.cfg console=tty0 console=ttyS0,115200n8 serial' \
