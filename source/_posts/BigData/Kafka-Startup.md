---
title: Kafka Startup
date: 2019-04-19 15:19:08
tags:
    - kafka
    - startup
    - cheatsheet
categories:
    - Tech
---

# Installation kafka 2.11

> See https://kafka.apache.org/11/documentation.html#quickstart


## 单节点
Download & install
```
wget http://mirrors.shu.edu.cn/apache/kafka/2.1.1/kafka_2.11-2.1.1.tgz
tar -zxf kafka_2.11-2.1.1.tgz
```
<!-- more -->

Start server
```bash
# 因为依赖ZK，所以需要启动ZK
# 如果没有安装，也可以运行kafka自带的
bin/zookeeper-server-start.sh config/zookeeper.properties
# 启动kafak
bin/kafka-server-start.sh config/server.properties
```

### Demo
Create topic (on zk)
```
bin/kafka-topics.sh --create \
    --zookeeper 127.0.0.1:2181 \
    --replication-factor 1 \
    --partitions 1 \
    --topic mytopic
```

List topic (on zk)
```
bin/kafka-topics.sh --list --zookeeper localhost:2181
```

Send message
```
bin/kafka-console-producer.sh --broker-list localhost:9092 --topic mytopic
输入一些字
```

Consume message
同时能看到上面的输入
```bash
# >=2.11-2.1.1
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 \
    --topic mytopic \
    --from-beginning

# older version
bin/kafka-console-consumer.sh --zookeeper localhost:2181 \
    --topic mytopic \
    --from-beginning
```

## 多节点

Let's expand our cluster to three nodes (still all on our local machine).


First we make a config file for each of the brokers 
```
cp config/server.properties config/server-1.properties
cp config/server.properties config/server-2.properties
```

Update config file
```
config/server-1.properties:
    broker.id=1
    listeners=PLAINTEXT://:9093
    log.dir=/tmp/kafka-logs-1
 
config/server-2.properties:
    broker.id=2
    listeners=PLAINTEXT://:9094
    log.dir=/tmp/kafka-logs-2
```

We already have Zookeeper and our single node started, so we just need to start the two new nodes:
```
bin/kafka-server-start.sh config/server-1.properties &
bin/kafka-server-start.sh config/server-2.properties &
```

### Demo

```
bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 3 --partitions 1 --topic my-replicated-topic

bin/kafka-topics.sh --describe --zookeeper localhost:2181 --topic my-replicated-topic
```

# Configuration

通常在 kafka/config/server.properties

> See https://kafka.apache.org/11/documentation.html#configuration

## Producer

- request.timeout.ms
配置控制客户端等待请求响应的最长时间。 如果在超时之前未收到响应，客户端将在必要时重新发送请求，如果重试耗尽，则该请求将失败。 
这应该大于replica.lag.time.max.ms(broker配置)，以减少由于不必要的生产者重试引起的消息重复的可能性。


## Change Port

```
listeners = PLAINTEXT://<ip>:9093
advertised.listeners=PLAINTEXT://<ip>:9093
```

## Java 参数
设置环境变量：KAFKA_HEAP_OPTS="-Xms512m -Xmx1g"
或者启动脚本

## 清理数据

```
log.retention.hours=168 //保留7d
log.retention.check.interval.ms=300000 //5min检查一次segment是否过期
log.segment.bytes=1073741824 //1G，超过生成一个新的
```

# Commands

## Topic

查看topic信息
```sh
bin/kafka-topics.sh --zookeeper 127.0.0.1:2181 --topic "test-topic" --describe
```
- "leader" is the node responsible for all reads and writes for the given partition. Each node will be the leader for a randomly selected portion of the partitions.
- "replicas" is the list of nodes that replicate the log for this partition regardless of whether they are the leader or even if they are currently alive.
- "isr" is the set of "in-sync" replicas. This is the subset of the replicas list that is currently alive and caught-up to the leader.


查看指定group信息
```sh
bin/kafka-topics.sh --new-consumer --bootstrap-server 127.0.0.1:9092 --group test-group --describe
```

## Balancing leadership

重平衡
```
bin/kafka-preferred-replica-election.sh --zookeeper 127.0.0.1:2181
```

## Consumer

查看消费组
```sh
# list
bin/kafka-consumer-groups.sh --bootstrap-server localhost:9092 --list

# describe group 
bin/kafka-consumer-groups.sh  --bootstrap-server localhost:9092 --group xxx --describe
# describe group - expired
bin/kafka-topics.sh --new-consumer --bootstrap-server 127.0.0.1:9092 --group test-group --describe

```