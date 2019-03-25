# 使用docker部署项目
docker部署微服务，redis，mysql，mongo


## docker部署微服务
`micro service`文件中包含两个微服务`dockerFile`使用`dockerFile`生成镜像。
```
docker build -t="service/eureka" .
docker build -t="service/export" .
```
执行
```
docker-compose up
```
运行`spring-boot`微服务。

查看容器配置命令
```
docker inspect #containerId
docker ps -a
docker exec -it #containerId /bin/bash
```


## docker部署redis
docker部署`redis` 1主2从3哨兵
`redis`文件中包含`redis`服务默认配置和哨兵默认配置文件，自定义`redis`的dockerFile，
容器启动的入口脚本，docker-compose文件。
  
`redis`配置在docker-compose文件环境变量中，容器执行启动脚本命令时会替换默认配置文件内容。

执行
```
docker-compose up
```
启动`redis`主从+哨兵服务。

`redis`命令行执行
````
info replication
````
查看`redis`实例配置信息
  
  