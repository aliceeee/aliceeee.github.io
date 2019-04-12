[![Build Status](https://travis-ci.org/aliceeee/aliceeee.github.io.svg?branch=hexo_version)](https://travis-ci.org/aliceeee/aliceeee.github.io)

# Introduction

My blog

# Development

Branch master, is release branch.

Branch hexo_version, is current development branch.

## Local setup

- Install nodejs

- Clone code

- Run 
```
npm install
npm install hexo-deployer-git --save
npm i hexo-generator-json-content --save  # support Yilia filter
npm install hexo-toc --save # support toc
```

## Local Run

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

# Reference

* [Hexo](https://hexo.io/zh-cn/docs/) 

* [Theme Yilia](https://github.com/litten/hexo-theme-yilia)

* [Theme NexT](http://theme-next.iissnan.com/)