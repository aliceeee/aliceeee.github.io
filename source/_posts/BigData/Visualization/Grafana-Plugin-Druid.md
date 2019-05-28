---
title: Grafana Plugin - Druid
tags:
  - grafana
  - plugin
  - druid
  - apache
categories:
  - Tech
date: 2019-05-22 15:12:25
---


# 背景

Grafana从apache druid数据源获取数据。找到以下官方插件，但是很久不更新了。

> 官方插件开发：https://github.com/grafana-druid-plugin/druidplugin

另外有一个贡献者的forked version
> 维护者相关讨论：https://github.com/grafana-druid-plugin/druidplugin/issues/91 
> forked version：https://github.com/GoshPosh/druidplugin 

<!-- more -->


# 加入开发
Fork项目地址：git@github.com:aliceeee/druidplugin.git

代码目录下
```sh
npm install
grunt
cd ..
zip druidplugin.zip druidplugin
```
把zip放到grafana的plugins目录下，重启grafana


# 二次开发
## 支持grafana dashboard variable

> 讨论：https://github.com/grafana-druid-plugin/druidplugin/issues/47

参考以上讨论中的实现

```js src/datasource.ts
  metricFindQuery(query: any) {

    let druidSqlQuery = {
      query: this.templateSrv.replace(query),  // 为了实现variable相互引用，实现级联查询
      context: {
        "sqlTimeZone": this.periodGranularity
      }
    }

    return new Promise((resolve, reject) => {
      this._druidQuery(druidSqlQuery, "/druid/v2/sql")
        .then(
          result => {
            let variableData =
              result.data
                .map(row => {
                  let vals = []
                  for (let property in row) {
                    vals.push({ "text": row[property] })
                  }
                  return vals;
                })
                .reduce((a, b) => {
                  return a.concat(b)
                })

            resolve(variableData)
          },
          error => {
            console.log(error.data.errorMessage)
            reject(new Error(error.data.errorMessage))
          }
        )
    })
  }
  _druidQuery(query, path = "/druid/v2/") {
    let options = {
      method: 'POST',
      url: this.url + path,
      data: query
    };
    console.log("Make http request");
    console.log(options);
    return this.backendSrv.datasourceRequest(options);
  };
```

# 参考

> 官方插件开发指南：https://grafana.com/docs/plugins/developing/development/
> 官方datasource插件开发：https://grafana.com/docs/plugins/developing/datasources/