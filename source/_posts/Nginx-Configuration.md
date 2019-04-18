---
title: Nginx Configuration
tags:
  - nginx
  - configuration
categories:
  - Tech
date: 2019-04-12 16:19:20
---


## Introduction

官方：http://nginx.org/en/docs/beginners_guide.html

Nginx VS. Nginx Plus: https://www.nginx.com/products/nginx/#compare-versions

<!-- more -->

## Concept
- Directives: Simple (single‑line) directives; Block directives
- Contexts: A few top‑level directives, referred to as contexts, group together the directives that apply to different traffic types. Directives placed outside of these contexts are said to be in the main context.
  - events – General connection processing
  - http – HTTP traffic
  - mail – Mail traffic
  - stream – TCP and UDP traffic
- Virtual Servers: `server` blocks
- Inheritance: 
  - > See [UNDERSTANDING THE NGINX CONFIGURATION INHERITANCE MODEL](http://blog.martinfjordvald.com/2012/08/understanding-the-nginx-configuration-inheritance-model/)

## Configuration File

Configuration file is typically one of /usr/local/nginx/conf, /etc/nginx, or /usr/local/etc/nginx.

文件最后一般有includes，例如：include /usr/local/nginx/conf/vhost/*.conf;

```conf
user nobody; # a directive in the 'main' context

events {
    # configuration of connection processing
}

http {
    # Configuration specific to HTTP and affecting all virtual servers  

    server {
        # configuration of HTTP virtual server 1       
        location /one {
            # configuration for processing URIs starting with '/one'
        }
        location /two {
            # configuration for processing URIs starting with '/two'
        }
    } 
    
    server {
        # configuration of HTTP virtual server 2
    }
}

stream {
    # Configuration specific to TCP/UDP and affecting all virtual servers
    server {
        # configuration of TCP virtual server 1 
    }
}

```

> See [Sample Configuration File with Multiple Contexts](https://docs.nginx.com/nginx/admin-guide/basic-functionality/managing-configuration-files/#sample-configuration-file-with-multiple-contexts)


## Debug Nginx Configuration

error_log 默认`[notice]`级别

例如：
```
error_log    /var/logs/nginx/error.log debug;
```

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

Nginx 记录仅仅来自于你的 IP 的错误日志
```
events {
        debug_connection 1.2.3.4;
}
```
## Virtual Servers

One or more server blocks define virtual servers

## Serving Static Content

```
server {
    location / {
        root /data/www;
    }

    location /images/ {
        root /data;
    }
}
```

## Reverse Proxy

```
upstream tomcats {
    server 127.0.0.1:9001;
    server 127.0.0.1:9002;
}
location / {
    proxy_pass_header Server;
    proxy_set_header Host $http_host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_pass http://tomcats;
}
```
> See [NGINX Reverse Proxy](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/)
> See [nginx http upstream module](http://nginx.org/en/docs/http/ngx_http_upstream_module.html#upstream)

### Custom Error Page

```
  location / {
          proxy_pass http://example/;
          proxy_set_header  X-Real-IP  $remote_addr;
          proxy_set_header  X-Forwarded-For  $remote_addr;
          error_page 502 503 504 /maintainance.html;
  }

  location = /maintainance.html {
          root /path/to/html/;
  }
```

### Websocket Support

```
location ~ /ws {
  proxy_pass http://127.0.0.1:8888;
  proxy_http_version 1.1;
  proxy_set_header Upgrade $http_upgrade;
  proxy_set_header Connection "upgrade";
}
```


## Nginx Error Code

> See [HTTP Return Codes](https://www.nginx.com/resources/wiki/extending/api/http/#http-return-codes)

### 403 / Forbidden errors

对于Nginx代理spring boot项目websocket出现403，修改配置
```
  # Pass the csrf token (see https://de.wikipedia.org/wiki/Cross-Site-Request-Forgery)
  # Default in Spring Boot and required. Without it nginx suppresses the value
  proxy_pass_header X-XSRF-TOKEN;

  # Set origin to the real instance, otherwise a of Spring security check will fail
  # Same value as defined in proxy_pass
  proxy_set_header Origin "http://testsysten:8080";  
```

> See [Nginx Reverse Proxy Websocket Authentication - HTTP 403
](https://stackoverflow.com/questions/34136630/nginx-reverse-proxy-websocket-authentication-http-403)


### 499 / ClientClosed Request

>499 / ClientClosed Request
>
>    An Nginx HTTP server extension. This codeis introduced to log the case when the connection is closed by client whileHTTP server is processing its request, making server unable to send the HTTP header back

Solution
- 解决server响应慢问题，在client close请求前返回
- nginx增加配置，不要主动关闭客户端的连接
```conf
proxy_ignore_client_abort  on; 
```

> See [服务器排障 之 nginx 499 错误的解决](https://blog.51cto.com/yucanghai/1713803)

### 504 / Gateway Timeout error

For Nginx as Proxy for Apache web server, this is what you have to try to fix the 504 Gateway Timeout error:

Add these variables to nginx.conf file:
```
proxy_connect_timeout       300;
proxy_send_timeout          300;
proxy_read_timeout          300;
send_timeout                300;
```

> See [How to Fix 504 Gateway Timeout using Nginx](https://www.scalescale.com/tips/nginx/504-gateway-time-out-using-nginx/)

