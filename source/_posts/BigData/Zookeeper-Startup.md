---
title: Zookeeper Startup
date: 2019-05-10 16:55:41
tags:
    - startup
    - zookeeper
categories:  
    - Tech
---

ZooKeeper: A Distributed Coordination Service for Distributed Applications

> See https://zookeeper.apache.org/doc/current/zookeeperOver.html

<!-- more -->


# Install

## Standalone Mode on CentOS7

> Download: http://www.apache.org/dyn/closer.cgi/zookeeper/

```
wget https://mirrors.tuna.tsinghua.edu.cn/apache/zookeeper/stable/zookeeper-3.4.14.tar.gz
tar -zxf zookeeper-3.4.14.tar.gz 
cd zookeeper-3.4.14
```

创建文件conf/zoo.cfg
```
tickTime=2000
dataDir=/var/lib/zookeeper
clientPort=2181
```

Start zk
```
bin/zkServer.sh start
```


## Replicated ZooKeeper

至少三台，建议奇数台server，每台安装zk

新建文件dataDir/myid，内容是server number, in ASCII

conf/zoo.cfg 
```
tickTime=2000
dataDir=/var/lib/zookeeper
clientPort=2181
initLimit=5
syncLimit=2
server.1=zoo1:2888:3888
server.2=zoo2:2888:3888
server.3=zoo3:2888:3888
```



# Startup

进入控制台
```
# bin/zkCli.sh -server 127.0.0.1:2181
Connecting to 127.0.0.1:2181

[zk: 127.0.0.1:2181(CONNECTED) 1] ls /
[zookeeper]
```

简单例子
```
# 进入控制台以后
create /zk_test my_data
ls /
get /zk_test
set /zk_test junk
delete /zk_test
ls /
```

查看kafka的topic
ls /brokers/topics

检查状态
http://zookeeper.apache.org/doc/r3.1.2/zookeeperAdmin.html#sc_zkCommands
$ echo stat | nc 127.0.0.1 2181

# Q&A