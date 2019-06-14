---
title: Windows Batch
date: 2019-04-26 15:04:50
tags:
categories:
---

# Basic

> [Batch Script Tutorial](https://www.tutorialspoint.com/batch_script/)

## Q&A
> [How to set a variable inside a loop for /F](https://stackoverflow.com/questions/13805187/how-to-set-a-variable-inside-a-loop-for-f)

<!-- more -->

# Network

## DNS

DNS刷新缓存
```bat
ipconfig /flushdns
```
## Netstat
端口占用和杀死占用端口进程
```bat
# 端口占用
netstat -aon|findstr "80"

# 进程6604情况
tasklist|findstr "6604"

# 杀死进程
taskkill /T /F /PID 6604
```

# File & Directory

## 磁盘使用
https://docs.microsoft.com/zh-cn/sysinternals/downloads/du

```bat
du.exe -h
usage: du [-c[t]] [-l <levels> | -n | -v] [-u] [-q] <directory>
   -c     Print output as CSV. Use -ct for tab delimiting.
          Use -nobanner to suppress banner.
   -l     Specify subdirectory depth of information (default is one level).
   -n     Do not recurse.
   -q     Quiet.
   -nobanner
          Do not display the startup banner and copyright message.
   -u     Count each instance of a hardlinked file.
   -v     Show size (in KB) of all subdirectories.
```

# Reference

> [Windows批处理(cmd/bat)常用命令教程](https://www.cnblogs.com/xpwi/p/9626959.html)