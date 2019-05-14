---
title: Druid
tags:
  - startup
  - druid
  - apache
categories:
  - Tech
date: 2019-05-10 18:12:25
---

Apache Druid (incubating) is a data store designed for high-performance slice-and-dice analytics ("OLAP"-style) on large data sets. 

> See http://druid.io

<!-- more -->

# 介绍

> See [Druid基础介绍和系统架构](https://www.jianshu.com/p/2347abf563df)



# Architecture

> See http://druid.io/docs/0.14.0-incubating/design/index.html#architecture

## Processes and Servers

每个Druid process type可以独立配置、扩缩容

Pprocess types
- Coordinator processes manage data availability on the cluster.
- Overlord processes control the assignment of data ingestion workloads.
- Broker processes handle queries from external clients.
- Router processes are optional processes that can route requests to Brokers, Coordinators, and Overlords.
- Historical processes store queryable data.
- MiddleManager processes are responsible for ingesting data.

推荐部署方案
- Master: Runs Coordinator and Overlord processes, manages data availability and ingestion.
- Query: Runs Broker and optional Router processes, handles queries from external clients.
- Data: Runs Historical and MiddleManager processes, executes ingestion workloads and stores all queryable data.

## External dependencies
深度存储(Deep Storage)，比如HDFS、S3等
元数据存储(Metadata Storage)，比如Mysql、PostgreSQL
Zookeeper，用于管理集群状态

# Install

> See http://druid.io/docs/0.14.0-incubating/tutorials/index.html
> See [Druid系统安装与配置](https://www.jianshu.com/p/a4b8bf4c82b9)

## Standalone

### Environment
CentOs7, 8G of RAM, 2 vCPUs
Java 8

### Installation
> See https://www.apache.org/dyn/closer.cgi?path=/incubator/druid/0.14.0-incubating/apache-druid-0.14.0-incubating-bin.tar.gz

```
wget http://mirrors.tuna.tsinghua.edu.cn/apache/incubator/druid/0.14.0-incubating/apache-druid-0.14.0-incubating-bin.tar.gz
tar -xzf apache-druid-0.14.0-incubating-bin.tar.gz
cd apache-druid-0.14.0-incubating
```

启动服务
```
bin/supervise -c quickstart/tutorial/conf/tutorial-cluster.conf
```
启动后，
- 持久化数据在（深度存储和元数据存储）在本地${DRUID_HOME}/var目录下
- 日志在本地${DRUID_HOME}/var/sv/*.log
- Resetting cluster state: 删除./var目录
- Resetting Kafka: 删除./tmp/kafka-logs

如果出现启动报错， zk.log出现：Error: Could not find or load main class org.apache.zookeeper.server.quorum.QuorumPeerMain



# Startup

# Q&A
