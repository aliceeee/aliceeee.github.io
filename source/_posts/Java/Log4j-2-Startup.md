---
title: Log4j 2 Startup
tags:
  - startup
categories:
  - Tech
date: 2019-05-23 15:54:26
---

# Introduction

<!-- more -->

# Use Log4j alone

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

## Configuration

> http://logging.apache.org/log4j/2.x/manual/configuration.html


## Install Log4j with Slf4j

> https://www.slf4j.org/manual.html

```xml pom.xml
<dependency> 
  <groupId>org.slf4j</groupId>
  <artifactId>slf4j-log4j12</artifactId>
  <version>1.8.0-beta4</version>
</dependency>
```
这会同时包含slf4j-api和log4j-1依赖


# Usage

## 标准输出

```
log4j.rootLogger=info, stdout

log4j.appender.stdout = org.apache.log4j.ConsoleAppender
log4j.appender.stdout.Target = System.out
log4j.appender.stdout.layout = org.apache.log4j.PatternLayout
log4j.appender.stdout.layout.ConversionPattern = [%-5p] %d{yyyy-MM-dd HH:mm:ss,SSS} method:%l%n%m%n

```