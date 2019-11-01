---
title: Grafana
tags:
  - startup
  - grafana
categories:
  - Tech
date: 2019-05-15 19:23:47
---

# Introduction

Grafana - UI of analytics and monitoring
The open platform for beautiful analytics and monitoring
No matter where your data is, or what kind of database it lives in, you can bring it together with Grafana. Beautifully.

<!-- more -->

# Installation 6.1.6 on CentOS7

> See http://docs.grafana.org/installation/rpm/

下载
```
wget https://dl.grafana.com/oss/release/grafana-6.1.6.linux-amd64.tar.gz
tar -zxvf grafana-6.1.6.linux-amd64.tar.gz
cd grafana-6.1.6
```

启动服务
```
./bin/grafana-server web
```

启动后，
- 日志: ./data/log/
- sqlite3 数据库：./data/grafana.db
- 插件：./data/plugins/

# Configuration

> See https://grafana.com/docs/installation/configuration/

Default configuration from `$WORKING_DIR/conf/defaults.ini`
Custom configuration from `$WORKING_DIR/conf/custom.ini`

Example
```
[database]
url=mysql://user:pwd@ip:3306/grafana
type=mysql

[auth.anonymous]
enabled = true
org_role = Viewer

[security]
# set to true if you want to allow browsers to render Grafana in a <frame>, <iframe>, <embed> or <object>. default is false.
# https://github.com/grafana/grafana/issues/14189
allow_embedding = true

```

## 自定义配置

会覆盖默认配置
```
touch conf/custom.ini
```

## 默认账号

默认登录账号
```
cat conf/defaults.ini |grep admin
```


# 插件

> Install Plugins: http://docs.grafana.org/plugins/installation/
> Plugin Repo: https://grafana.com/plugins

## 手动安装插件

下载插件的git代码，目录文件放到grafana.ini上面配置的plugin地址（例如：/var/lib/grafana/plugins），重启服务即可

插件位置配置，例如/etc/grafana/grafana.ini
```
#################################### Paths ####################################
[paths]

# Directory where grafana will automatically scan and look for plugins
plugins = /var/lib/grafana/plugins
```

## 使用grafana-cli安装插件

```
 ./bin/grafana-cli plugins install abhisant-druid-datasource
 ```

## 插件：Pie Chart
> https://grafana.com/plugins/grafana-piechart-panel

提供饼图


## 插件：Druid
> https://grafana.com/plugins/abhisant-druid-datasource
> 维护者：https://github.com/grafana-druid-plugin/druidplugin/issues/91

使用druid作为datasource

问题：
和dashboard的variable不能很好整合，方案讨论：https://github.com/grafana-druid-plugin/druidplugin/issues/47


# 参考

官网： https://grafana.com/
官网文档：http://docs.grafana.org/
Getting started: http://docs.grafana.org/guides/getting_started/
Alert配置：https://blog.csdn.net/Jailman/article/details/78920166
