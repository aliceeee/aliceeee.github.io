---
title: Log4j 2 Startup
tags:
  - startup
categories:
  - Tech
date: 2019-05-23 15:54:26
---

# Introduction

> 官网：http://logging.apache.org/log4j/2.x/

<!-- more -->

# Installation

## Install
>  See http://logging.apache.org/log4j/2.x/maven-artifacts.html
Maven pom.xml
```xml pom.xml
  <dependency>
    <groupId>org.apache.logging.log4j</groupId>
    <artifactId>log4j-api</artifactId>
    <version>2.11.2</version>
  </dependency>
  <dependency>
    <groupId>org.apache.logging.log4j</groupId>
    <artifactId>log4j-core</artifactId>
    <version>2.11.2</version>
  </dependency>
```

## Install Log4j with Slf4j

> https://www.slf4j.org/manual.html

pom.xml
```xml 
<dependency> 
  <groupId>org.slf4j</groupId>
  <artifactId>slf4j-log4j12</artifactId>
  <version>1.8.0-beta4</version>
</dependency>
```
这会同时包含slf4j-api和log4j-1依赖

# Configuration

> http://logging.apache.org/log4j/2.x/manual/configuration.html

Configuration of Log4j 2 can be accomplished in 1 of 4 ways:

- Through a configuration file written in XML, JSON, or YAML.
- Programmatically, by creating a ConfigurationFactory and Configuration implementation.
- Programmatically, by calling the APIs exposed in the Configuration interface to add components to the default configuration.
- Programmatically, by calling methods on the internal Logger class.


# Usage

## 日志到标准输出

log4j.properties
```properties
log4j.rootLogger=info, STDOUT

log4j.appender.STDOUT=org.apache.log4j.ConsoleAppender
#log4j.appender.STDOUT.Target=System.out
log4j.appender.STDOUT.layout=org.apache.log4j.PatternLayout
log4j.appender.STDOUT.layout.ConversionPattern=[%-5p] %d{yyyy-MM-dd HH:mm:ss,SSS} method:%l%n%m%n

```

## 日志到文件
log4j.properties
```properties
log4j.appender.LOGFILE=org.apache.log4j.RollingFileAppender
log4j.appender.LOGFILE.MaxFileSize=100MB
log4j.appender.LOGFILE.MaxBackupIndex=10
log4j.appender.LOGFILE.File=/tmp/xxx.log
log4j.appender.LOGFILE.layout=org.apache.log4j.PatternLayout
log4j.appender.LOGFILE.layout.ConversionPattern=%d{yyyy-MM-dd HH:mm:ss.SSS} %p [metric-detection] [%t] %c %x - %m%n
```

## 指定某些包/类的日志

log4j.properties
```properties
log4j.logger.org.test=debug,console

# 默认情况下 子Logger 会继承 父Logger 的appender，也就是说 子Logger 会在 父Logger 的appender里输出。
# 若是additivity设为false，则 子Logger 只会在自己的appender里输出，而不会在 父Logger 的appender里输出。
log4j.additivity.org.test=false
```
