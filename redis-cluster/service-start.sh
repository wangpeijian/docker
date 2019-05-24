#!/usr/bin/env bash

# 1.创建redis镜像
docker rmi nosql/redis-cluster-node
docker build -t="nosql/redis-cluster-node" .

# 2.创建redis-cli镜像
docker rmi nosql/redis-center
docker build -t="nosql/redis-cluster-center" ./redis-cluster-center

# 2.生成compose文件, 节点数 端口号 密码
#./compose-builder.sh $1 $2 $3

# 3.启动compose文件
docker-compose up