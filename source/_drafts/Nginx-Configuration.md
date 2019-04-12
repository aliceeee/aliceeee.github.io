---
title: Nginx Configuration
tags:
    - nginx
    - configuration
categories:
    - Tech
toc: true        
---

# 如何调试Nginx配置

error_log 默认`[notice]`级别

仅收集rewrite错误
```
server {
    error_log    /var/logs/nginx/error.log;
    rewrite_log on;
}
```

仅调试/admin/部分
```
server {
    #other config
    error_log    /var/logs/nginx/example.com.error.log;
    location /admin/ { 
        error_log /var/logs/nginx/admin-error.log debug; 
    }         
    #other config
}
```

指定错误级别
```
error_log    /var/logs/nginx/error.log debug;
```

Nginx 记录仅仅来自于你的 IP 的错误日志
```
events {
        debug_connection 1.2.3.4;
}
```
