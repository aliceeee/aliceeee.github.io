---
title: Spark Startup
date: 2019-05-27 10:05:18
tags:
    - spark
    - starkup
categories:
    - Tech
---



# Installation

## Spark 2.4.0 Standalone Monde 

> See https://spark.apache.org/docs/latest/spark-standalone.html

<!-- more -->

Pre-install
jdk 8

Download
https://spark.apache.org/downloads.html

```sh
wget http://mirror.bit.edu.cn/apache/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz
tar -zxf spark-2.4.0-bin-hadoop2.7.tgz
cd spark-2.4.0-bin-hadoop2.7
```

Start server
```sh
./sbin/start-master.sh
```

启动后
- WebUI: http://ip_address:8080/
- Spark服务：7077


## Starting a Cluster Manually
> See https://spark.apache.org/docs/latest/spark-standalone.html#starting-a-cluster-manually

使用命令手动启动整个集群。类似上面，启动更多worker并关联到mater
```
./sbin/start-slave.sh <master-spark-URL>
```

## Cluster Launch Scripts
使用脚本启动集群
> See https://spark.apache.org/docs/latest/spark-standalone.html#cluster-launch-scripts

创建配置 <SPARK_HOME>/conf/slaves，内容是所有worker的主机名，一行一个。
如果不存在conf/slaves即单机模式。
master和worker通过ssh


# Configuration

> https://spark.apache.org/docs/latest/configuration.html

## Environment variables
scripts启动可以复制conf/spark-env.sh.template创建配置： conf/spark-env.sh

# Startup

## Running the Examples and Shell
https://spark.apache.org/docs/latest/#running-the-examples-and-shell

```
cd <SPARK_HOME>
# bin/run-example <class> [params]
./bin/run-example SparkPi 10
```

## Launching Spark Applications
使用spark-submit

> See https://spark.apache.org/docs/latest/submitting-applications.html

分析上面命令 bin/run-example，可以得到运行测试任务SparkPi 的实际命令是
```
 ./bin/spark-submit run-example SparkPi 10
```
