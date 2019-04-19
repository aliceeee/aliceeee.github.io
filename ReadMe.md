[![Build Status](https://travis-ci.org/aliceeee/aliceeee.github.io.svg?branch=hexo_version)](https://travis-ci.org/aliceeee/aliceeee.github.io)

# Introduction

My blog

# Development

Branch master, is release branch.

Branch hexo_version, is current development branch.

## Install

- Install nodejs
略

- Clone code
略

- Run 
```
npm install
npm install hexo-deployer-git --save
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

## Theme: Yilia
安装略

额外安装
```
npm i hexo-generator-json-content --save  # support Yilia filter
```

## Theme: NexT
安装略

### Local search

> See [Next主题优化](https://www.jianshu.com/p/428244cd2caa)
```
npm install hexo-generator-searchdb --save
npm install hexo-wordcount --save
```

修改站点_config.yml
```
search:
  path: search.xml
  field: post
  format: html
  limit: 10000
```

修改themes/next下的_config.yml,搜索关键字local_search,设置为true
```
local_search:
  enable: true
```

### 统计功能，统计功能,显示文章字数统计,阅读时长,总字数

> See [theme-next/hexo-symbols-count-time](https://github.com/theme-next/hexo-symbols-count-time)

```
npm install hexo-symbols-count-time --save
```

修改站点_config.yml
```
symbols_count_time:
    symbols: true
    time: true
    total_symbols: true
    total_time: true
```    

修改Next的_config.yml
```
symbols_count_time:
  separated_meta: true
  item_text_post: true
  item_text_total: false
  awl: 4
  wpm: 275
```

### toc support

>  [Hexo toc](https://github.com/bubkoo/hexo-toc)

问题是使用后侧栏的目录会失效，所以不使用
```
npm install hexo-toc --save # support toc, usage: https://github.com/bubkoo/hexo-toc
```

# Reference

* [Hexo](https://hexo.io/zh-cn/docs/) 

* [Theme Yilia](https://github.com/litten/hexo-theme-yilia)

* [Theme NexT](http://theme-next.iissnan.com/)