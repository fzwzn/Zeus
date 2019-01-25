#!/bin/bash

#author:fzw
#date:2019-01-23
#install docker
error_log=/myshell/$0.log
echo -e "----------------------------------------------------\n===============remove================"
#remove installed docker
yum remove -y docker docker-common docker-selinux docker-engine #>/dev/null 2>$error_log

echo -e "----------------------------------------------------\n===================iinstall rely on====================="
#install rely on
yum install -y yum-utils device-mapper-persistent-data lvm2 #>/dev/null 2>$error_log

echo -e "----------------------------------------------------\n========================donwload docker-ce.repo====================="
#downlod docker-ce.repo
wget -O /etc/yum.repos.d/docker-ce.repo https://download.docker.com/linux/centos/docker-ce.repo #>/dev/null 2>$error_log
#把软件仓库地址替换为 TUNA:
sed -i 's+download.docker.com+mirrors.tuna.tsinghua.edu.cn/docker-ce+' /etc/yum.repos.d/docker-ce.repo #>/dev/null 2>$error_log

yum makecache fast -y #>/dev/null 2>$error_log

echo -e "----------------------------------------------------\n==================install docker===================="#>>/myshell/$0.log
#install docker
yum install docker-ce -y 2>$error_log
p1=$?
if [ ! $p1 -eq 0 ];then
	echo "install has error..."
#View the cause of the software installation error
	grep container-selinux $error_log | grep -v grep 2>>$error_log
	echo "==========container-selinux have to up==========="
	p2=$?
	if [ $p2 -eq 0 ];then
		#echo -e "-------------------------------------------------\n==================Download new version container-selinux================="
#download new version container-linux
		#wget http://rpm.pbone.net/index.php3/stat/4/idpl/40704222/dir/centos_7/com/container-selinux-2.9-4.el7.noarch.rpm.html/container-selinux-2.9-4.el7.noarch.rpm
#install new version container-selinux
				
		echo -e "----------------------------------------------------------------\n======================install container-selinux==============="
#install container-selinux
		yum localinstall -y container-selinux-2.9-4.el7.noarch.rpm #>/dev/null 2>$error_log
		if [ $? -eq 0 ];then
			echo -e "------------------------------------------------------------\n=================new version container-selinux install successfull========"
			echo -e "----------------------------------------------------\n==============================install docker==============================="#>>/myshell/$0.log
#install docker 
			yum install docker-ce -y #>/dev/null 2>$error_log
				if [ $? -eq 0 ];then
					echo "===========docker install successfull=============="
				fi	
		fi
	fi
fi
