FROM maven:3-jdk-8-alpine as MVN_BUILD

LABEL maintainer="fzb<fzb2469081876@163.com>"

RUN mvn package -DskipTests -Pci

# 将当前目录下的jar包复制到docker容器的/目录下
ADD target/Tbed-2.0-Free.jar /Tbed-2.0-Free.jar
# 运行过程中创建一个mall-tiny-docker-file.jar文件
RUN bash -c 'touch /Tbed-2.0-Free.jar'
# 声明服务运行在8888端口
EXPOSE 8888
# 指定docker容器启动时运行jar包
ENTRYPOINT ["java", "-jar","/Tbed-2.0-Free.jar"]
