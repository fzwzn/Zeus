#!/bin/bash

#author:fzw
#date:2019-01-23
#install docker

#镜像加速器
#Mirror_accelerator=

echo  "此脚本会执行yum update 命令，该命令会更新诸多软件版本，确定是否执行"
read -t 5 -p "Is this ok [y/d/N]:" chose
[ $chose != y ] && exit

yum update -$chose
[ $? != 0 ] && exit

yum remove -y docker docker-common docker-selinux docker-engine docker*
[ $? != 0 ] && exit

#如果安装提示container-selinux版本低，取消下端内容的注释
#wget ftp://ftp.pbone.net/mirror/ftp.centos.org/7.7.1908/cloud/x86_64/openstack-train/container-selinux-2.84-2.el7.noarch.rpm
#yum localinstall container-selinux-2.84-2.el7.noarch.rpm

yum install -y yum-utils device-mapper-persistent-data lvm2
[ $? != 0 ] && exit

rm -rf /etc/yum.repos.d/docker*
[ $? != 0 ] && exit

wget -O /etc/yum.repos.d/docker-ce.repo https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/centos/docker-ce.repo
yum makecache st y
[ $? != 0 ] && exit

yum install docker-ce -y
[ $? != 0 ] && exit
#配置镜像加速器
rm -rf /etc/docker
mkdir /etc/docker
#cat << EOF >> /etc/docker/daemon.json
#{
#  "registry-mirrors": ["$Mirror_accelerator"]
#}
#EOF
