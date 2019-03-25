FROM java

MAINTAINER peijian.wang

EXPOSE 9080

ADD ./build/libs/service-export-0.0.1-SNAPSHOT.jar /home/app.jar

ENTRYPOINT ["java", "-jar", "/home/app.jar"]