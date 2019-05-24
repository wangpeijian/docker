#!/usr/bin/env bash
# 环境变量

# $MASTER_PASSWORD 主机密码


# 修改配置文件基本内容
# 主从节点配置文件
# **********************************************************************************
sed -i "s/protected-mode yes/protected-mode no/g" /redis.conf
sed -i "s/daemonize yes/daemonize no/g"           /redis.conf
sed -i "s/bind 127.0.0.1/bind 0.0.0.0/g"          /redis.conf
sed -i "s/# masterauth <master-password>/masterauth '$MASTER_PASSWORD'/g"          /redis.conf
sed -i "s/# requirepass foobared/requirepass '$MASTER_PASSWORD'/g"          /redis.conf
# **********************************************************************************

echo "启动Redis服务"

# redis 集群配置
sed -i "s/# cluster-enabled yes/cluster-enabled yes/g" /redis.conf
sed -i "s/# cluster-config-file nodes-6379.conf/cluster-config-file nodes-6379.conf/g" /redis.conf

(
sleep 1
echo "yes"
) | redis-cli -a 123456 --cluster create 172.99.0.2:6379 172.99.0.3:6379 172.99.0.4:6379 172.99.0.5:6379 172.99.0.6:6379 172.99.0.7:6379 --cluster-replicas 1



