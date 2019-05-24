#!/usr/bin/env bash

# 通过参数传递需要建立多少个节点的集群
NODES=$1
LINKS=$1
PORT_START=$2
PASSWORD=$3

let PORT_START--


# 输出基础内容
echo "version: '2.2'

networks:
    redis-cluster-net:
        driver: bridge

services:"> docker-compose.yml

# 生成节点信息
INDEX=1
while :
do
   if [ $INDEX -gt $NODES ]
    then
       break
    else

       let PORT_START++

        echo "准备生成节点配置, node: redis-cluster-node-$INDEX  port: $PORT_START"


        echo "    redis-cluster-node-$INDEX:
        image: nosql/redis-cluster-node
        container_name: "redis-cluster-node-$INDEX"
        networks:
            - redis-cluster-net
        ports:
            - "$PORT_START:6379"
        environment:
            MASTER_PASSWORD: $PASSWORD
        " >> docker-compose.yml

        let INDEX++
    fi
done

echo "内容生成完毕"


