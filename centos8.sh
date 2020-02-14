#!/bin/bash

#下载centos禁Ping
wget http://dlam.ml/ssr-download/sysctl.conf

#将脚本移动到/etc/rc.d/init.d目录下
mv -f /root/sysctl.conf /etc/

#保存后执行sysctl -p命令配置生效
sysctl -p

#查看防火墙状态
firewall-cmd --state

#停止防火墙
systemctl stop firewalld.service

#禁止防火墙开机启动
systemctl disable firewalld.service

#禁止PING本机
echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_all

#下载docker-ce的repo
curl https://download.docker.com/linux/centos/docker-ce.repo -o /etc/yum.repos.d/docker-ce.repo

#安装依赖（这是相比centos7的关键步骤）
yum install https://download.docker.com/linux/fedora/30/x86_64/stable/Packages/containerd.io-1.2.6-3.3.fc30.x86_64.rpm -a

#安装docker-ce
yum install docker-ce

#启动docker
systemctl start docker

#设置开机启动
systemctl enable docker
systemctl list-unit-files | grep enable
