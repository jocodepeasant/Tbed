FROM maven:3-jdk-8-alpine as MVN_BUILD
# 容器内工作目录
WORKDIR /opt/tbed/
# 复制宿主机项目文件到容器内
ADD . /tmp
# 在容器内进行项目编译
RUN cd /tmp && mvn package -DskipTests -Pci \
&& mv target/* /opt/tbed/ \
&& chmod 777 /opt/tbed/*

FROM openjdk:8-alpine
LABEL maintainer="fzb<fzb2469081876@163.com>"

WORKDIR /opt/tbed/

# 声明服务运行在8888端口
EXPOSE 8888
# 指定docker容器启动时运行jar包
ENTRYPOINT ["java", "-jar","Tbed-2.0-Free.jar"]
