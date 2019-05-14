---
title: Linux Shell Cheatsheet
date: 2019-04-26 15:04:50
tags:
categories:
---

<!-- more -->

# Network

## DNS

DNS刷新缓存
```
service nscd restart
service dnsmasq restart
rndc restart
```

查看某个record 何时才能失效,假设你的默认dns server 不是authoritative server
```
dig +nocmd +noall +answer www.google.com
```
查看某个record 从authoritative server 请求一个record 时被设置的ttl
```
dig @ns1.google.com +nocmd www.google.com +noall +answer
```

## Proxy

/etc/profile
```
export http_proxy=xxx
export https_proxy=xxx
```

## tc

> See [linux 下使用 tc 模拟网络延迟和丢包](https://blog.csdn.net/weiweicao0429/article/details/17578011)

```
# 将 eth0 网卡的传输设置为延迟 100 毫秒发送
tc qdisc add dev eth0 root netem delay 100ms
# 删除上面配置
tc qdisc del dev eth0 root netem delay 100ms

```