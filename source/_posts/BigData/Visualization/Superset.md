---
title: Superset
tags:
  - startup
  - superset
  - bi
categories:
  - Tech
date: 2019-05-10 16:53:30
---

Apache Superset (incubating) is a modern, enterprise-ready business intelligence web application

> See https://github.com/apache/incubator-superset

<!-- more -->


# Install superset 0.28.1

环境
CentOS 7
python 3.6
virtualenv-16.5.0

安装步骤
```sh

sudo yum upgrade python-setuptools
sudo yum install gcc gcc-c++ libffi-devel python-devel python-pip python-wheel openssl-devel libsasl2-devel openldap-devel # 或者python36-pip/python36-devel等，根据版本选择

# install virtualenv(略)

# active virtualenv
source ${virtualenv}/bin/activate

pip install --upgrade setuptools pip 

# Install superset
pip install superset
superset version

# Create an admin user (you will be prompted to set a username, first and last name before setting a password)
fabmanager create-admin --app superset

# Initialize the database
superset db upgrade

# Load some data to play with
superset load_examples

# Create default roles and permissions
superset init

# To start a development web server on port 8088, use -p to bind to another port
superset runserver -d
```

启动后，数据库sqlite:////root/.superset/superset.db

访问：http://ip_address:8088


# Startup

## 创建Druid数据源
1. Sources > Druid Clusters > add
2. Sources > Scan New DataSources

# Q&A

- pip install superset 报错：pyconfig.h: No such file or directory

需要安装python-devel

- fabmanager create-admin --app superset 报错：Was unable to import superset Error: cannot import name '_maybe_box_datetimelike'

这是 pandas 库版本太高导致的，需要安装低版本的 pandas 库
```sh
$ pip list | grep pandas
pandas                 0.24.2  

$ pip install pandas==0.23.4
```

- superset db upgrade 报错：sqlalchemy.exc.InvalidRequestError: Can't determine which FROM clause to join from, there are multiple FROMS which can join to this entity. 

SQLAlchemy 库版本太高导致的，需要安装低版本的 SQLAlchemy 库
```sh
$ pip list | grep -i sqlalchemy
Flask-SQLAlchemy       2.4.0   
marshmallow-sqlalchemy 0.16.3  
SQLAlchemy             1.3.3   
SQLAlchemy-Utils       0.33.11 

$ pip install SQLAlchemy==1.2.18
```

- dashboard中使用filter组件筛选，会出现组件空白
https://github.com/apache/incubator-superset/issues/6165
