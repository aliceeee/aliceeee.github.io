---
title: Python Virtual Env
tags:
  - python
categories:
  - Tech
date: 2019-05-14 17:00:22
---

Python 环境管理

<!-- more -->


# Virtualenv

> See https://virtualenv.pypa.io/en/stable/

virtualenv is a tool to create isolated Python environments.

## Install

> https://virtualenv.pypa.io/en/stable/installation/

环境： CentOS 7, python34, pip

安装

```sh
pip install virtualenv

Successfully installed virtualenv-16.5.0
```

## Startup

初始化
```
virtualenv ENV27
```
新建ENV27目录（可改变）存放virtual environment.

新增python
```
virtualenv -p /usr/bin/python3.6 ENV36
```

激活环境
```
source ENV/bin/activate　
# or
. ENV/bin/activate
```
之后提示符前面会一直显示当前环境名

停用环境
```
deactivate
```

删除环境
```
rm -r /path/to/ENV
```


# Anaconda
> See https://www.anaconda.com/

Anaconda是专注于数据分析的Python发行版本，包含了conda、Python等190多个科学包及其依赖项。
