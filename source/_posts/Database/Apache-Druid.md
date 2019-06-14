---
title: Apache Druid
tags:
  - startup
  - druid
  - apache
categories:
  - Tech
date: 2019-05-10 18:12:25
---

Apache Druid (incubating) is a data store designed for high-performance slice-and-dice analytics ("OLAP"-style) on large data sets. 

> See http://druid.io/docs/latest/design/index.html#what-is-druid

> Druid GitHub地址：https://github.com/apache/incubator-druid

<!-- more -->


# Architecture

> See http://druid.io/docs/0.14.0-incubating/design/index.html#architecture
>
> See [Druid基础介绍和系统架构](https://www.jianshu.com/p/2347abf563df)

![Druid Architecture](http://druid.io/docs/img/druid-architecture.png "Druid Architecture")

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

```sh
wget http://mirrors.tuna.tsinghua.edu.cn/apache/incubator/druid/0.14.0-incubating/apache-druid-0.14.0-incubating-bin.tar.gz
tar -xzf apache-druid-0.14.0-incubating-bin.tar.gz

cd apache-druid-0.14.0-incubating

# tutorial 启动脚本要求的zk位置
ln -s ../zookeeper-3.4.14 zk

# start server
bin/supervise -c quickstart/tutorial/conf/tutorial-cluster.conf
```

访问：
Druid Overlord Console: http://localhost:8090/console.html
Druid Unified Console: http://localhost:8888/unified-console.html
CoordinatorConsole: http://localhost:8081

启动后，
- 持久化数据在（深度存储和元数据存储）：${DRUID_HOME}/var目录下
  - zk:2181，数据文件var/zk
- 日志：${DRUID_HOME}/var/sv/*.log
- Resetting cluster state: 删除${DRUID_HOME}/var目录
- Resetting Kafka: 删除/tmp/kafka-logs
- 组件进程和端口映射
  - zk:2181
  - coordinator:8081
  - broker:8082
  - historical:8083
  - router:8888
  - overlord:8090
  - middleManager:8091

如果出现启动报错， zk.log出现：Error: Could not find or load main class org.apache.zookeeper.server.quorum.QuorumPeerMain，检查zk引用是否正确。


## Clustering
> See http://druid.io/docs/0.14.0-incubating/tutorials/cluster.html


# Tutorial

## Tutorial: Loading a file

使用 Apache Druid (incubating)'s native batch ingestion，提交一个ingestion task（quickstart/tutorial/wikipedia-index.json），加载数据（quickstart/tutorial/wikiticker-2015-09-12-sampled.json.gz）

1. 提交task

> See http://druid.io/docs/0.14.0-incubating/tutorials/tutorial-batch.html

```sh
## 方法一，使用脚本，但是python报错：httplib.BadStatusLine: ''（TODO）
# bin/post-index-task --file quickstart/tutorial/wikipedia-index.json 

## 方法二
curl -X 'POST' -H 'Content-Type:application/json' -d @quickstart/tutorial/wikipedia-index.json http://localhost:8090/druid/indexer/v1/task # 使用ip
```
成功后返回task id

2. 查询task

> See http://druid.io/docs/0.14.0-incubating/tutorials/tutorial-query.html

- 使用Native JSON queries
```sh
curl -X 'POST' -H 'Content-Type:application/json' -d @quickstart/tutorial/wikipedia-top-pages.json http://localhost:8082/druid/v2?pretty # 使用ip
```

- 使用Druid SQL queries

http请求
```sh
curl -X 'POST' -H 'Content-Type:application/json' -d @quickstart/tutorial/wikipedia-top-pages-sql.json http://localhost:8082/druid/v2/sql # 使用ip
```

或者dsql client （同样python报错：httplib.BadStatusLine: ''）（TODO）
```sh
$ bin/dsql
Welcome to dsql, the command-line client for Druid SQL.
Connected to [http://localhost:8082/].

Type "\h" for help.
dsql> SELECT page, COUNT(*) AS Edits FROM wikipedia WHERE "__time" BETWEEN TIMESTAMP '2015-09-12 00:00:00' AND TIMESTAMP '2015-09-13 00:00:00' GROUP BY page ORDER BY Edits DESC LIMIT 10;
```

- 访问页面
http://localhost:8888/unified-console.html#tasks 看到task状态SUCCESS
http://localhost:8888/unified-console.html#datasources 查看Datasources状态 Fully available
http://localhost:8888/unified-console.html#sql 运行SQL


## Tutorial: Roll-up
> http://druid.io/docs/latest/tutorials/tutorial-rollup.html

Roll-up是导入数据时做的初步聚合操作，可以减少存储数据

```sh
bin/post-index-task --file quickstart/tutorial/rollup-index.json 
# or
curl -X 'POST' -H 'Content-Type:application/json' -d @quickstart/tutorial/rollup-index.json http://localhost:8090/druid/indexer/v1/task # 使用ip
```
查看sql
```sql
select * from "rollup-tutorial";
```

## Tutorial: Updating existing data

# SQL

> http://druid.io/docs/latest/querying/sql.html

# Data Ingestion

## Kafka Indexing Service (Stream Pull)
> http://druid.io/docs/0.14.0-incubating/development/extensions-core/kafka-ingestion.html