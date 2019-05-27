#!/usr/bin/env bash

# 修改配置文件基本内容
# **********************************************************************************
sed -i "s/protected-mode yes/protected-mode no/g" /redis.conf
sed -i "s/daemonize yes/daemonize no/g"           /redis.conf
sed -i "s/bind 127.0.0.1/bind 0.0.0.0/g"          /redis.conf
# **********************************************************************************

echo "启动Redis-cli"

(
sleep 1
echo "yes"
) | redis-cli -a 123456 --cluster create 172.99.0.2:6379 172.99.0.3:6379 172.99.0.4:6379 172.99.0.5:6379 172.99.0.6:6379 172.99.0.7:6379 --cluster-replicas 1

while true
do
    sleep 10
    echo "保证容器进程不关闭"
done