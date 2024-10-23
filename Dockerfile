# 使用 Ubuntu 22.04 作为基础镜像
FROM ubuntu:22.04

# 避免交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装 OpenWrt 编译所需的依赖
RUN apt-get update && apt-get install -y \
    build-essential clang flex bison g++ gawk gcc-multilib g++-multilib \
    gettext git libncurses5-dev libssl-dev python3-distutils rsync unzip zlib1g-dev \
    file wget

# 安装 Go 1.23.2
RUN wget https://go.dev/dl/go1.23.2.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.23.2.linux-amd64.tar.gz && \
    rm go1.23.2.linux-amd64.tar.gz

# 设置 Go 环境变量
ENV PATH=$PATH:/usr/local/go/bin
ENV GOPATH=/go
ENV PATH=$PATH:$GOPATH/bin

# 验证 Go 安装
RUN go version

# 设置工作目录
WORKDIR /openwrt

# 设置默认命令
CMD ["/bin/bash"]
