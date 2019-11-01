---
title: XML-Based Swagger 2 Configuration With Spring MVC
tags:
  - spring
  - mvc
  - swagger2
categories:
  - Tech
date: 2019-06-27 11:01:23
---

# Introduction

> [XML-Based Swagger 2 Configuration With Spring MVC](https://dzone.com/articles/xml-based-swagger-2-configuration-with-spring-mvc)

Below is the step-by-step guide to configuring Swagger 2 with Spring MVC using an XML-based configuration.

<!-- more -->

# Env

spring version: 4.0.5.RELEASE

servlet-api: 2.5

Springfox-swagger: 2.6.1

# Steps

```xml pom.xml

<!--Dependency for swagger 2 -->
<dependency>
  <groupId>io.springfox</groupId>
  <artifactId>springfox-swagger2</artifactId>
  <version>2.6.1</version>
</dependency>
<!--Dependency for swagger ui -->
<dependency>
  <groupId>io.springfox</groupId>
  <artifactId>springfox-swagger-ui</artifactId>
  <version>2.6.1</version>
</dependency>
```

```xml servlet-context.xml
  <!--Here com.example.service is the base package for swagger configuration -->
  <context:component-scan base-package="com.example.service" use-default-filters="false">
    <context:include-filter type="annotation" expression="org.springframework.stereotype.Controller" />
    <context:include-filter type="annotation" expression="org.springframework.web.bind.annotation.ControllerAdvice" />
  </context:component-scan>

  <!-- for swagger -->
  <bean id="swagger2Config"
        class="springfox.documentation.swagger2.configuration.Swagger2DocumentationConfiguration">
  </bean>

  <mvc:resources order="1" location="/resources/"
                  mapping="/resources/**" />
  <mvc:resources mapping="swagger-ui.html"
                  location="classpath:/META-INF/resources/" />
  <mvc:resources mapping="/webjars/**"
                  location="classpath:/META-INF/resources/webjars/" />

  <mvc:default-servlet-handler />                  
```

```xml web.xml
    <servlet>
        <servlet-name>xxx</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
        <init-param>
            <param-name>contextConfigLocation</param-name>
            <param-value>classpath:servlet-context.xml</param-value>
        </init-param>
        <load-on-startup>1</load-on-startup>
    </servlet>
```

Start server and visit `http://<Your Host>:<Port>/<Context>/Swagger-ui.html `