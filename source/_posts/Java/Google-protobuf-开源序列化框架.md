---
title: Google protobuf - 开源序列化框架
tags:
  - startup
categories:
  - Tech
date: 2019-09-24 18:14:13
---

# Introduction

> 官方文档：https://developers.google.com/protocol-buffers/?hl=zh-CN

> 官方代码：https://github.com/protocolbuffers/protobuf

> Google Protocol Buffer 的使用和原理： https://www.ibm.com/developerworks/cn/linux/l-cn-gpb/index.html

> Protobuf 有没有比 JSON 快 5 倍？： https://www.infoq.cn/article/json-is-5-times-faster-than-protobuf

Protocol buffers are a language-neutral, platform-neutral extensible mechanism for serializing structured data.


<!-- more -->

# Install

## IntellJ Plugin
插件 Protobuf Support

## Java maven project

```xml
<properties>
    <protobuf.version>2.5.0</protobuf.version>
</properties>

<dependencies>
    <dependency>
        <groupId>com.google.protobuf</groupId>
        <artifactId>protobuf-java</artifactId>
        <version>${protobuf.version}</version>
    </dependency>
    <dependency>
        <groupId>com.googlecode.protobuf-java-format</groupId>
        <artifactId>protobuf-java-format</artifactId>
        <version>1.4</version>
    </dependency>
</dependencies>

<build>
    <plugins>

        <plugin>
            <groupId>com.github.os72</groupId>
            <artifactId>protoc-jar-maven-plugin</artifactId>
            <version>3.5.1.1</version>
            <executions>
                <execution>
                    <phase>generate-sources</phase>
                    <goals>
                        <goal>run</goal>
                    </goals>
                    <configuration>
                        <protocVersion>${protobuf.version}</protocVersion>
                        <inputDirectories>
                            <include>src/main/proto</include>
                        </inputDirectories>
                        <!-- <outputTargets>
                            <outputTarget>
                                <type>java</type>
                                <addSources>none</addSources>
                                <outputDirectory>target/generated-sources/java</outputDirectory>
                            </outputTarget>
                        </outputTargets> -->
                    </configuration>
                </execution>
            </executions>
        </plugin>

    </plugins>
</build>
```

# Manual 2.5
> 官方java版：https://developers.google.com/protocol-buffers/docs/javatutorial?hl=zh-CN

## Example

- 写proto文件
```addressbook.proto
syntax = "proto2";

package tutorial;

option java_package = "com.example.tutorial";
option java_outer_classname = "AddressBookProtos";

message Person {
required string name = 1;
required int32 id = 2;
optional string email = 3;

enum PhoneType {
MOBILE = 0;
HOME = 1;
WORK = 2;
}

message PhoneNumber {
required string number = 1;
optional PhoneType type = 2 [default = HOME];
}

repeated PhoneNumber phones = 4;
}

message AddressBook {
repeated Person people = 1;
}
```

- 下载编译器 Download Protocol Buffers
> https://github.com/protocolbuffers/protobuf/releases/tag/v2.5.0
可以用windows版本：protoc-2.5.0-win32

- 编译1：手动编译
项目根目录下
```batch
protoc.exe --version
protoc.exe -I src\main\proto\ --java_out=src\main\java\ src\main\proto\Person.proto
```
得到java类，注意包名

- 编译2：maven编译
配置如上面pom，target对应目录上会生成java文件，所在文件夹设为java source即可
> 参考：https://www.cnblogs.com/crazymakercircle/p/10093385.html

问题：编译失败

- 使用
```java
Person  p = Person .newBuilder().setName(ByteString.copyFromUtf8("somename")).build();
```
## Protobuf to String

```java
Person  p = Person .newBuilder().setName(ByteString.copyFromUtf8("somename")).build();
String str = TextFormat.printToUnicodeString(p);
```
逐一输出所有字段，和proto文件格式类似

## Protobuf to JSON
使用fastjson等失败，需要用
```xml
<dependency>
<groupId>com.googlecode.protobuf-java-format</groupId>
<artifactId>protobuf-java-format</artifactId>
<version>1.4</version>
</dependency>
```
使用
```java
byte[] content = xxx;
UserBaseInfo user = UserBaseInfo.parseFrom(content);
String json = new JsonFormat().printToString(user );
```

如果对象中有字段是中文，看保存字段类型，如果是bytestring，那么会出现编码问题。如果string可能没问题。


## JSON to Protobuf

```java

UserPurposeSumInfo.Builder builder = UserPurposeSumInfo.newBuilder();
new JsonFormat().merge(new ByteArrayInputStream(jsonStr.getBytes()), builder);

UserPurposeSumInfo info = builder.build();

```

## String to ByteString

类赋值的时候需要类型转换
```java

public static ByteString toByteString(String value) {
  return ByteString.copyFromUtf8(value);
}

```

