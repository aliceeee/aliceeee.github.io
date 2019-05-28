---
title: Flink Startup
date: 2019-04-23 10:05:18
tags:
    - flink
    - starkup
categories:
    - Tech
---



# Installation

## Local Setup Flink 1.7 on Linux

> See https://ci.apache.org/projects/flink/flink-docs-release-1.7/tutorials/local_setup.html

<!-- more -->

Pre-install
jdk 8

Download
https://flink.apache.org/downloads.html

```
wget http://mirror.bit.edu.cn/apache/flink/flink-1.7.2/flink-1.7.2-bin-scala_2.11.tgz
tar xzf flink-*.tgz
cd flink-1.7.2

./bin/start-cluster.sh
```

浏览器访问：http://localhost:8081

## Local Setup on Windows

> See https://ci.apache.org/projects/flink/flink-docs-release-1.7/tutorials/flink_on_windows.html

Download 同上 & 解压

```
cd D:\flink-1.7.2\bin
start-cluster.bat
```
浏览器访问：http://localhost:8081


# Configuration

flink-1.7.2/conf/flink-conf.yaml


# Streaming Example：SocketWindowWordCount

Java代码：https://github.com/apache/flink/blob/master/flink-examples/flink-examples-streaming/src/main/java/org/apache/flink/streaming/examples/socket/SocketWindowWordCount.java

打好的包在安装目录下examples下都有

会话1，本地启动server监听9009
```bash
nc -l 9009
```
会话2，运行example
```bash
cd $FLINK_HOME

./bin/flink run examples/streaming/SocketWindowWordCount.jar --port 9009
```
会话3，查看结果
```bash
tail -f flink-*-taskexecutor-*.out
```
在会话1中输入一些什么，按回车提交

这个例子功能是：每5s统计输入（会话1）的单词出现次数
