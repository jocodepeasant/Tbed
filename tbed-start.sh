#! /bin/bash
set -x
set +e
name=Tbed #部署应用名
if [ ! -d "/tmp" ]; then
    mkdir /tmp
fi

echo "开始拉取最新代码"
cd /tmp \
&& git clone https://github.com/Hello-hao/Tbed.git \

#判断容器是否存在，存在则删除
docker ps -a | grep $name &> /dev/null
if [ $? -eq 0 ]; then
    echo "暂停并删除旧容器及镜像"
    docker stop $name
    docker rm $name
fi

echo "开始构建 docker 容器"
cd Tbed \
&& docker build -t Tbed:latest .

echo "开始运行容器"
docker run -it --name $name -d -p8888:80 \
--env spring.datasource.username="root" \
--env spring.datasource.password="fzb8004568933" \
--env spring.datasource.url="jdbc:mysql://116.205.172.86:3306/solo?useUnicode=yes&characterEncoding=UTF-8&useSSL=false&serverTimezone=UTC" \
Tbed