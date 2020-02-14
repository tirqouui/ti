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

#安装docker-ce
curl -sSL https://get.docker.com | bash

#启动docker
service docker restart

#设置开机启动
systemctl enable docker

#查看开机启动项
systemctl list-unit-files | grep enable
