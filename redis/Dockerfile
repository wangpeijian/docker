FROM redis

MAINTAINER peijian.wang

EXPOSE 6379

# 添加配置文件
ADD ./redis.conf /redis.conf
ADD ./sentinel.conf /sentinel.conf

# 添加启动脚本
COPY ./redis-start.sh /redis-start.sh

ENTRYPOINT ["sh", "/redis-start.sh"]