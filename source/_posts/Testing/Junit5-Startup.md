---
title: Junit5 Startup
tags:
  - junit
  - test
categories:
  - Tech
date: 2019-04-22 10:03:00
---

<!-- more -->


# Introduction

The new major version of the programmer-friendly testing framework for Java

官网：https://junit.org/junit5/

User Guide: https://junit.org/junit5/docs/current/user-guide/#overview

# Getting Started

https://github.com/junit-team/junit5-samples/tree/r5.4.2/junit5-jupiter-starter-maven

<!-- more -->

pom.xml
```
<?xml version="1.0" encoding="UTF-8"?>

<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    
    <!-- omit -->

    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <maven.compiler.source>1.8</maven.compiler.source>
        <maven.compiler.target>1.8</maven.compiler.target>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter</artifactId>
            <version>5.4.2</version>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <pluginManagement>
            <plugins>
                <plugin>
                    <artifactId>maven-surefire-plugin</artifactId>
                    <version>2.22.1</version>
                </plugin>
            </plugins>
        </pluginManagement>
    </build>
</project>
```
