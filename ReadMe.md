[![Build Status](https://travis-ci.org/aliceeee/aliceeee.github.io.svg?branch=hexo_version)](https://travis-ci.org/aliceeee/aliceeee.github.io)

# Introduction

My blog

# Dependency

## Hexo

[Hexo](https://hexo.io/zh-cn/docs/) is a fast, simple & powerful blog framework

* Environment

Install nodejs

Run 
```
npm install -g hexo
```
* Init

Go to the project root directory.

For the first time, run
```shell
hexo init 
```

After clone, run
```shell
npm install
npm install hexo-deployer-git --save
```

* Usage

```shell
hexo new [layout] <title>

hexo publish [layout] <filename>

hexo generate
hexo g -d -w # -d同时部署；-w 监视变化

# http://localhost:4000/
hexo server

# deploy to, like github
hexo  deploy
hexo d -g # -g 同时生成静态文件

# clean cache (db.json) and generated static files (public)。
hexo clean

hexo list <type>
```


