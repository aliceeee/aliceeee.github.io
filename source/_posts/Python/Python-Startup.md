---
title: Python Startup
tags:
  - python
  - startup
categories:
  - Tech
date: 2019-05-14 17:00:22
---


<!-- more -->

# Install

## Installation python
```sh
# install
yum install python36

# 如果有旧版本，例如python2，修改默认python
cd /usr/bin
rm -rf python
rm -rf python2 # 是否需要？
ln -s python3.4 python

# check
python -V
```

## Q&A

- 解决系统python软链接指向python2.7版本后，yum不能正常工作

修改/usr/bin/yum，将文件头部的
```sh
#!/usr/bin/python
```
改成
```sh
#!/usr/bin/python2.4.3
```
