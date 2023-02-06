---
title: Flink源码编译
tags:
  - flink
  - sourcecode
categories:
  - Tech
date: 2023-01-30 11:57:25
---

# Introduction

Flink源码编译

> 官方ide配置：https://nightlies.apache.org/flink/flink-docs-master/docs/flinkdev/ide_setup/
>
> 官方编译：https://nightlies.apache.org/flink/flink-docs-master/docs/flinkdev/building/
>
> 官方开发规范：https://flink.apache.org/contributing/code-style-and-quality-java.html

<!-- more -->

# Flink v1.16

Environment
- jdk8
- 机器内存最好>3G，否则容易出现内存不足

```sh
git clone https://github.com/apache/flink.git
git checkout 
cd flink

# [optional] 代码自动格式化
mvn spotless:apply

# 编译打包
# skip test but still comple test class
# skip QA plugins and javadoc generation by using the fast Maven profile
# skip the WebUI compilation
# skip checkstyle
# skip spotless check
mvn clean package \
-DskipTests \
-Dfast \
-Pskip-webui-build \
-Dcheckstyle.skip \
-Dspotless.check.skip=true 

# 完成以后
ll flink-dist/target/flink-1.*-bin/flink-1.*
```

