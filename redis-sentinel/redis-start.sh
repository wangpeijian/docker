# 环境变量
# $REDISE_ROLE redis启动角色
# $MASTER_HOST 主机地址
# $MASTER_PORT 主机端口
# $MASTER_PASSWORD 主机端口
# $MASTER_QUORUM 哨兵仲裁数量

# 修改配置文件基本内容
# 主从节点配置文件
# **********************************************************************************
sed -i "s/protected-mode yes/protected-mode no/g" /redis.conf
sed -i "s/daemonize yes/daemonize no/g"           /redis.conf
sed -i "s/bind 127.0.0.1/bind 0.0.0.0/g"          /redis.conf
sed -i "s/# masterauth <master-password>/masterauth '$MASTER_PASSWORD'/g"          /redis.conf
sed -i "s/# requirepass foobared/requirepass '$MASTER_PASSWORD'/g"          /redis.conf
# **********************************************************************************

# 哨兵节点配置文件
# **********************************************************************************
sed -i "s/# protected-mode no/protected-mode no/g" /sentinel.conf
sed -i "s/daemonize yes/daemonize no/g"           /sentinel.conf
sed -i "s/# bind 127.0.0.1 192.168.1.1/bind 0.0.0.0/g"          /sentinel.conf
sed -i "s/# sentinel auth-pass <master-name> <password>/sentinel auth-pass mymaster '$MASTER_PASSWORD'/g"          /sentinel.conf
# **********************************************************************************


echo "当前角色： $REDISE_ROLE"

if [ $REDISE_ROLE = "master" ]; then

	echo "以master启动"

	redis-server /redis.conf
elif [ $REDISE_ROLE = "slave" ]; then

	echo "以slave启动,master: $MASTER_HOST:$MASTER_PORT"
	sed -i "s/# replicaof <masterip> <masterport>/replicaof '$MASTER_HOST' '$MASTER_PORT'/g" /redis.conf
	redis-server /redis.conf

elif [ $REDISE_ROLE = "sentinel" ]; then

	echo "以sentinel启动,master: $MASTER_HOST:$MASTER_PORT"
	sed -i "s/sentinel monitor mymaster 127.0.0.1 6379 2/sentinel monitor mymaster '$MASTER_HOST' '$MASTER_PORT' '$MASTER_QUORUM'/g" /sentinel.conf
	redis-server /sentinel.conf  --sentinel
	
else
	echo "错误的角色：$REDISE_ROLE"
fi