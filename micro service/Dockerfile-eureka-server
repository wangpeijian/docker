FROM java

MAINTAINER peijian.wang

EXPOSE 9001

ADD ./build/libs/service-eureka-0.0.1-SNAPSHOT.jar /home/app.jar

ENTRYPOINT ["java", "-jar", "/home/app.jar"]