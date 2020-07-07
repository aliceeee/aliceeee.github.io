---
title: Paddlepaddle Installation
tags:
  - paddlepaddle
  - docker
categories:
  - Tech
date: 2020-03-11 17:47:03
---

# Introduction

> 官网：https://www.paddlepaddle.org.cn/

源于产业实践的开源深度学习平台


# Install

> paddlepaddle官方Dockerfile：https://github.com/PaddlePaddle/Paddle/blob/develop/Dockerfile


<!-- more -->


## 环境

> CentOS下安装: https://www.paddlepaddle.org.cn/documentation/docs/zh/install/install_CentOS.html

操作系统需满足CentOS 7 (64 bit)(GPU版本支持CUDA 9.0/9.1/9.2/10.0/10.1, 其中CUDA 9.1仅支持单卡)
```
# uname -m && cat /etc/*release
```

Python安装，略

检查Python（参考 Python Installation & Python - pip）
检查Python 版本 2.7.15+/3.5.1+/3.6/3.7 (64 bit)
检查pip 或 pip3 版本 9.0.1+ (64 bit)
确认Python和pip是64bit，并且处理器架构是x86_64
建议python2/3命令分开，运行时采用`python -m pip xxxx`的格式指定pip
```sh
python --version
python -m pip --version
python -c "import platform;print(platform.architecture()[0]);print(platform.machine())"
```

更新pip如果安装时报pip版本不够
```
python -m pip install --upgrade pip -i http://pypi.douban.com/simple --trusted-host pypi.douban.com
```

## CentOS CPU版 pip安装
> https://www.paddlepaddle.org.cn/install/doc/centos

- 环境

按照上面检查CentOS、python

- 安装

一定要使用baidu的源

```sh
python -m pip install paddlepaddle -i https://mirror.baidu.com/pypi/simple
```

- 验证
```sh
python
>>> import paddle.fluid as fluid
>>> fluid.install_check.run_check()
...Your Paddle Fluid is installed successfully!..
```

- 卸载
```sh
python -m pip uninstall paddlepaddle
```

- 如果报： error in nltk setup command: 'install_requires' must be a string or list of strings containing valid project/version requirement specifiers
运行以下命令更新setuptools 再重试
```sh
pip install setuptools -U
```

## CentOS CPU版 Docker安装
> https://www.paddlepaddle.org.cn/install/doc/docker

- 环境

按照上面检查CentOS

安装Docker

- pull images
```sh
docker pull hub.baidubce.com/paddlepaddle/paddle:1.6.3
```

- run

```sh
docker run --name paddle -it -v $PWD:/paddle hub.baidubce.com/paddlepaddle/paddle:1.6.3 /bin/bash
```
验证方法同上


## CentOS CPU版 源码编译

```sh
git config --global http.sslVerify false
git clone https://github.com/PaddlePaddle/Paddle.git

cd Paddle

docker run --name paddle-test -v $PWD:/paddle --network=host -it hub.baidubce.com/paddlepaddle/paddle:latest-dev /bin/bash
```

## Kubernetes + CentOS GPU版 自定义docker镜像
> Install paddlepaddle-gpu：https://www.paddlepaddle.org.cn/documentation/docs/zh/install/install_CentOS.html#cpu-gpu

Kubernates+docker,调度GPU资源，业务通过镜像发布

- 安装
  - Kubernetes:
    - Enable NVIDIA device plugin for Kubernetes， 可以支持发布时配置gpu资源
  - Kubernetes GPU node：
    - 按照上面检查基本环境
    - Install Docker  略
    - Install nvidia driver 硬件驱动
    - Install nvidia-docker-plugin，为了方便的run映射了gpu设备的容器
  - Docker container：
    - 按照上面基本环境和python
    - Install cuda+cudnn 提供高性能的GPU应用开发环境
    - Install paddlepaddle-gpu 

### [Kubernetes] Enable NVIDIA device plugin for Kubernetes
> https://github.com/NVIDIA/k8s-device-plugin#prerequisites

Kubernetes version >= 1.10

```sh
kubectl create -f https://raw.githubusercontent.com/NVIDIA/k8s-device-plugin/1.0.0-beta4/nvidia-device-plugin.yml
```

### [GPU Node] Install Nvidia driver
> nvidia driver下载：https://www.nvidia.com/Download/Find.aspx?lang=en-us

验证：
```
cat /proc/driver/nvidia/version
```

### [GPU Node] Install nvidia-docker
> https://github.com/NVIDIA/nvidia-container-runtime

### [Docker container] Install dependencies
```sh
yum install -y wget which perl kernel-devel gcc gcc-c++ kernel-devel-$(uname -r) kernel-headers-$(uname -r)
```


### [Docker container] Install CUDA Toolkit

- 决定CUDA Toolkit版本
> cuda toolkit和Driver Version版本兼容关系：https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html

安装页面可以看到完整安装文件名

CUDA安装文件第二个下划线后面是驱动版本号，两个一致、或者driver version大于CUDA toolkit


- 安装CUDA Toolkit（使用runfile安装）

> CUDA安装步骤：https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#runfile

> CUDA下载页，需先选择环境：https://developer.nvidia.com/cuda-10.1-download-archive-update2?target_os=Linux&target_arch=x86_64&target_distro=CentOS&target_version=7&target_type=runfilelocal

```sh
wget http://developer.download.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda_10.1.243_418.87.00_linux.run
chmod +x cuda_10.*
cuda_10.* --toolkit --silent
echo "export PATH=$PATH:/usr/local/cuda/bin:/usr/local/cuda/NsightCompute-1.0" >> /etc/profile
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64" >> /etc/profile
```
验证CUDA Toolkit
```sh
# 查看版本
nvcc --version
cat /usr/local/cuda/version.txt

# 运行sample
cd /usr/local/cuda/samples/1_Utilities/deviceQuery && make
./deviceQuery

cd /usr/local/cuda/samples/1_Utilities/bandwidthTest && make
./bandwidthTest

cd /usr/local/cuda/samples/1_Utilities/deviceQueryDrv && make
./deviceQueryDrv
```

如果运行`./deviceQueryDrv`报：./deviceQueryDrv: error while loading shared libraries: libcuda.so.1: cannot open shared object file: No such file or directory
解决：查看依赖`ldd ./deviceQueryDrv`……各种查资料和尝试后最后发现因为启动容器的时候没有加参数`NVIDIA_DRIVER_CAPABILITIES`，导致没有mount进来

### [Docker container]  Install cuDNN

- 决定cudnn版本

目前一般都是安装版本v7，搭配cuda 9或10

- 安装cuDNN并验证

> cuDNN安装步骤：https://docs.nvidia.com/deeplearning/sdk/cudnn-install/#install-linux

```sh
tar -xzvf cudnn-*.tgz
cp cuda/include/cudnn.h /usr/local/cuda/include
cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
chmod 755 /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*

# 验证版本是：CUDNN_MAJOR 7,CUDNN_MINOR 6
cat /usr/local/cuda/include/cudnn.h | grep CUDNN_MAJOR -A 2
```

### [Docker container] Install paddlepaddle-gpu

- 决定paddlepaddle-gpu版本

> paddlepaddle-gpu包版本：https://pypi.org/project/paddlepaddle-gpu/#history

> paddlepaddle与CUDA,cuDNN版本的对应关系请见： https://www.paddlepaddle.org.cn/documentation/docs/zh/install/Tables.html#whls

因为paddlepaddle-gpu==[版本号].postXX 例如 paddlepaddle-gpu==1.7.0.post97 支持CUDA 9.0和cuDNN 7的对应PaddlePaddle版本的安装包。

- 安装paddlepaddle-gpu

```sh
# 对于Python 2：
python -m pip install paddlepaddle-gpu -i https://mirror.baidu.com/pypi/simple

# 对于Python 3：
python3 -m pip install paddlepaddle-gpu -i https://mirror.baidu.com/pypi/simple
```

- 验证

```sh
python
>>> import paddle.fluid as fluid
>>> fluid.install_check.run_check()

# 验证CUDAPlace函数： https://www.paddlepaddle.org.cn/documentation/docs/zh/1.6/api_cn/fluid_cn/CUDAPlace_cn.html
>>> gpu_place = fluid.CUDAPlace(0)
```


### 验证

- docker运行容器测试
类似
```
docker run --runtime=nvidia -e NVIDIA_DRIVER_CAPABILITIES=all -e NVIDIA_VISIBLE_DEVICES=all -it <image> /bin/bash
```
按照上面各项验证

- k8s测试
请求资源类似
```
resources:
    limits:
        nvidia.com/gpu: 2 # requesting 2 GPUs
```









