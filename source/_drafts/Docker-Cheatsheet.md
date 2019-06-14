---
title: Docker Cheatsheet
tags:
    - docker
    - cheatsheet
categories:
    - Tech
---

> See [Use the Docker command line](https://docs.docker.com/engine/reference/commandline/cli/)



# Common

```
docker version

docker --help
docker attach --help
```

<!-- more -->

# Images

Pull an image or a repository from a registry
```
docker pull debian:jessie
```

Build an image from a Dockerfile
```
docker build -t vieux/apache:2.0 .
docker build -f Dockerfile.debug .
```

To see which images are present locally
```
docker images
```


# Containers

```
docker ps -a

docker run ubuntu /bin/echo 'Hello world'

docker run --name mynginx -d nginx:latest

# -t flag assigns a pseudo-tty or terminal inside our new container
# -i flag allows us to make an interactive connection by grabbing the standard in (STDIN) of the container
docker run -t -i ubuntu /bin/bash
# -d flag tells Docker to run the container and put it in the background, to daemonize it
docker run -d ubuntu /bin/sh -c "while true; do echo hello world; sleep 1; done"
docker run -it nginx:latest /bin/bash
# -P flag is new and tells Docker to map any required network ports inside our container to our host
# -p 80:5000 map port 5000 inside our container to port 80 on our local host
docker run -p 127.0.0.1:80:8080/tcp ubuntu bash
docker run -p 80:80 -v /data:/data -d nginx:latest
docker run -P -d nginx:latest

docker logs 2b6333eb87ea
docker logs -f elegant_colden

docker top elegant_colden

docker inspect elegant_colden

docker inspect -f '{{ .NetworkSettings.IPAddress}}' elegant_colden

docker stop 2b6333eb87ea

docker restart elegant_colden

docker rm elegant_colden
docker rm `docker ps --no-trunc -aq`
docker rm $(docker ps -a -q)

```

# Save & Load

Save running container
```
docker save -o xxx.tar.gz 2b6333eb87ea
```

Save one or more images to a tar archive (streamed to STDOUT by default)
```
docker save busybox-1 > /home/save.tar
```

Load saved container
```
docker load -i xxx.tgz
docker load < xxx.tgz
```

Export命令用于持久化容器（不是镜像）: Export a container's filesystem as a tar archive
```
docker export <CONTAINER ID> > /home/export.tar
docker export --output="latest.tar" red_panda
```

# Monitor

A live data stream for running containers
```
docker stats [OPTIONS] [CONTAINER...]
```

# Volumn

Create data volumn

```
docker create -v /tools/ --name tools centos:6.6 /bin/true
```

Start a container with a new data volumn 

```
docker run -i -t -v /tools centos:6.6 /bin/bash
```

Mount a host directory as a data volume
```    
docker run -i -t -v /tmp/tools:/tools centos:6.6 /bin/bash
```

A read-only data volumn
```
docker run -i -t -v /tmp/tools:/tools:ro centos:6.6 /bin/bash
```
两个参数是:主机绝对路径or一个name:容器绝对路径:只读


Mount a host file as a data volume
```
docker run --rm -it -v ~/.bash_history:/root/.bash_history ubuntu /bin/bash
```

Remove a volumn
```
docker rm -v 
```


# Q & A

## `docker stop` has no effect and `docker rm --force` with 'device or resource busy'

```sh
# 找出没有umount的路径
cat /proc/mounts | grep "mapper/docker" | awk '{print $2}'

# 依次umount
# 略
```