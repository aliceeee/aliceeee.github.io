---
title: Kafka Startup
date: 2019-04-19 15:19:08
tags:
    - kafka
    - startup
categories:
    - Tech
---

<!-- more -->

# Installation kafka 2.11

Download
```
wget http://mirrors.shu.edu.cn/apache/kafka/2.1.1/kafka_2.11-2.1.1.tgz
tar -zxf kafka_2.11-2.1.1.tgz
```

Start server
```bash
# 因为依赖ZK，所以需要启动ZK
# 如果没有安装，也可以运行kafka自带的
bin/zookeeper-server-start.sh config/zookeeper.properties
# 启动kafak
bin/kafka-server-start.sh config/server.properties
```

# Configuration

kafka/config/server.properties

## Port

```
listeners = PLAINTEXT://<ip>:9093
advertised.listeners=PLAINTEXT://<ip>:9093
```

# Startup
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

