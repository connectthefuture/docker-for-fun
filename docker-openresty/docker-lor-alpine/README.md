libuuid
```

# Install Lua and LuaRocks
RUN apk add --update \
    --repository http://dl-1.alpinelinux.org/alpine/edge/testing/ \
    lua5.2 luarocks5.2 ca-certificates curl unzip \
    && rm -rf /var/cache/apk/*

# Create links
RUN ln -s /usr/bin/lua5.2 /usr/bin/lua \
    && ln -s /usr/bin/luarocks-5.2 /usr/bin/luarocks

```

```

ENV VERSION 2.2.2

WORKDIR /root
RUN apk update \ && apk add build-base gcc make curl automake autoconf tar \
		lua lua-dev --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
		&& apk upgrade \
		&& mkdir -m 777 -p /luarocks /lua \
		&& wget http://luarocks.org/releases/luarocks-2.2.2.tar.gz \
		&& tar -zxvf luarocks-2.2.2.tar.gz -C / \
		&& cd /luarocks-2.2.2 \
		&& ./configure; make bootstrap \
		&& luarocks install luasocket \
		&& apk del build-base gcc make curl automake autoconf tar \
		&& apk upgrade \
		&& rm -rf /var/cache/apk/* \
		&& cd /lua \
		&& rm -rf /luarocks \
		&& apk update
```

RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.3/main" >> /etc/apk/repositories; \
         echo " http://dl-cdn.alpinelinux.org/alpine/v3.3/community" >> /etc/apk/repositories; 


RUN echo "ipv6" >> /etc/modules
RUN echo "http://dl-1.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories; \
    echo "http://dl-2.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories; \
    echo "http://dl-3.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories; \
    echo "http://dl-4.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories; \
    echo "http://dl-5.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories; \
    echo "http://dl-1.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories; \
    echo "http://dl-2.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories; \
    echo "http://dl-3.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories; \
    echo "http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories; \
    echo "http://dl-5.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    echo "http://dl-1.alpinelinux.org/alpine/v3.3/main" >> /etc/apk/repositories; \
    echo "http://dl-2.alpinelinux.org/alpine/v3.3/main" >> /etc/apk/repositories; \
    echo "http://dl-3.alpinelinux.org/alpine/v3.3/main" >> /etc/apk/repositories; \
    echo "http://dl-4.alpinelinux.org/alpine/v3.3/main" >> /etc/apk/repositories; \
    echo "http://dl-5.alpinelinux.org/alpine/v3.3/main" >> /etc/apk/repositories; 

## 创建镜像

````
docker build  -t edwin/lor-openresty-alpine  .
````

## 启动镜像

````
docker run -d -p 8888:8888 edwin/lor-openresty-alpine
````

### ubuntu   
docker run -t -i -v /home/edwin-clear/resources/sourceCode/docker-for-fun/docker-openresty/docker-lor-alpine/lor-example:/tmp/lor-example/   -w=/tmp/lor-example/   edwin/lor-openresty-alpine  /bin/sh

docker run -t -i -p 8889:8888 -v /home/edwin-clear/resources/sourceCode/docker-for-fun/docker-openresty/docker-lor-alpine/openresty-china:/tmp/openresty-china/   -w=/tmp/openresty-china/   edwin/lor-openresty-alpine  /bin/sh

### mac

docker run -t -i -v /Users/wanghaisheng/workspace/docker-for-fun/docker-openresty/docker-lor-alpine/lor-example:/tmp/lor-example/   -w=/tmp/lor-example/   edwin/lor-openresty-alpine  /bin/sh

docker run -t -i -v /Users/wanghaisheng/workspace/docker-for-fun/docker-openresty/docker-lor-alpine/openresty-china:/tmp/openresty-china/   -w=/tmp/openresty-china/   edwin/lor-openresty-alpine  /bin/sh




如下示例均以宿主机系统为ubuntu来演示，mac windows系统可能会存在不同
##　如果你使用的是ubuntu自带的docker
docker run -t -i -v /home/edwin-clear/resources/sourceCode/docker-for-fun/docker-openresty/lor-alpine/demo1:/tmp/vdemo/   -w=/tmp/vdemo/   edwin/lor-openresty-alpine  /bin/sh

lor start

 check container ip
 ```
 docker inspect --format='{{.NetworkSettings.IPAddress}}' $CONTAINER_ID
 ➜  docker-for-fun git:(master) ✗ docker inspect --format='{{.NetworkSettings.IPAddress}}' 6da96
172.17.0.3
 ```
access
```
http://172.17.0.3:8888/
```




## 如果你使用docker-machine来管理镜像
首先挂载宿主机目录到boot2docker虚机内部，详情请参考[Folder sharing部分](https://github.com/boot2docker/boot2docker)

### 创建数据卷容器

docker run -v /home/edwin-clear/resources/sourceCode/docker-for-fun/docker-openresty/docker-lor-alpine/demo1 --name my-data busybox true



$ # Make a volume container (only need to do this once)
$ docker run -v /data --name my-data busybox true
$ # Share it using Samba (Windows file sharing)
$ docker run --rm -v /usr/local/bin/docker:/docker -v /var/run/docker.sock:/docker.sock svendowideit/samba my-data
$ # then find out the IP address of your Boot2Docker host
$ boot2docker ip
192.168.59.103

Connect to the shared folder using Finder (OS X):

Connect to cifs://192.168.59.103/data
Once mounted, will appear as /Volumes/data

Or on Windows, use Explorer to Connect to:

\\192.168.59.103\data

You can then use your data container from any container you like:

$ docker run -it --volumes-from my-data ubuntu

You will find the "data" volume mounted as "/data" in that container. Note that "my-data" is the name of volume container, this is shared via the "network" by the "samba" container that refers to it by name. So, in this example, if you were on OS-X you now have /Volumes/data and /data in container being shared. You can change the paths as needed.

### 先把宿主机的目录挂载到 docker-machine 创建的 boot2docker 虚机内部

```
It is also important to note that in the future, the plan is to have any share which is created in VirtualBox with the "automount" flag turned on be mounted during boot at the directory of the share name (ie, a share named home/jsmith would be automounted at /home/jsmith).
```
mount -t vboxsf -o uid=1000,gid=50 your-other-share-name /some/mount/location (每次docker-machine 重启 则失效 需要重新运行该命令)



通过 ssh 登录到你当前所选择的虚机中去
docker-machine  ssh dev

挂载宿主机与虚机的共享文件夹
sudo mount -t vboxsf -o rw,uid=1000,gid=50 hosthome /home

your-other-share-name 的值为 virtualbox软件 “设置”中当前虚机(例子中为dev)的共享文件夹名称(例子中为hosthome)
/some/mount/location 由于共享文件夹选择的是宿主机用户根目录 这里要挂载的目标文件夹也设置为/home 方便后续在docker run中路径的书写

sudo mount -t vboxsf -o uid=1000,gid=50 hosthome /home


这样我们要docker run 的时候 (如果测试用的项目目录在/home之内)路径就可以与宿主机保持一致。

```
docker run  --rm -t -i -v /home/edwin-clear/resources/sourceCode/docker-for-fun/docker-openresty/docker-lor-alpine/demo1:/tmp/vdemo/   -w=/tmp/vdemo/   --name my-app-dev  edwin/lor-openresty-alpine /bin/sh
```
测试
```
➜  docker-lor-alpine git:(master) ✗ docker-machine restart dev
Restarting "dev"...
Waiting for SSH to be available...
Detecting the provisioner...
Restarted machines may have new IP addresses. You may need to re-run the `docker-machine env` command.

➜  docker-lor-alpine git:(master) ✗ docker-machine restart dev
Restarting "dev"...
Waiting for SSH to be available...
Detecting the provisioner...
Restarted machines may have new IP addresses. You may need to re-run the `docker-machine env` command.
➜  docker-lor-alpine git:(master) ✗ eval $(docker-machine env dev)
➜  demo1 git:(master) ✗ docker run  --rm -t -i -v /home/edwin-clear/resources/sourceCode/docker-for-fun/docker-openresty/docker-lor-alpine/demo1:/tmp/vdemo/   -w=/tmp/vdemo/   --name my-app-dev  edwin/lor-openresty-alpine /bin/sh
/tmp/vdemo # ls -l
total 36
drwxr-xr-x    1 1000     50            4096 Feb 23 04:04 application
drwxr-xr-x    1 1000     50            4096 Feb 23 04:04 client_body_temp
drwxr-xr-x    1 1000     50            4096 Feb 23 04:04 config
drwxr-xr-x    1 1000     50            4096 Feb 23 04:04 fastcgi_temp
drwxr-xr-x    1 1000     50            4096 Feb 23 04:05 logs
drwxr-xr-x    1 1000     50            4096 Feb 23 04:04 proxy_temp
drwxr-xr-x    1 1000     50            4096 Feb 23 04:04 pub
drwxr-xr-x    1 1000     50            4096 Feb 23 04:04 spec
drwxr-xr-x    1 1000     50            4096 Feb 23 04:05 tmp
/tmp/vdemo # lor start --trace
/opt/openresty/nginx/sbin/nginx  -g "env VA_ENV=development;" -p `pwd`/ -c tmp/development-nginx.conf
nginx: [alert] lua_code_cache is off; this will hurt performance in /tmp/vdemo/tmp/development-nginx.conf:25
lor app in development was succesfully started on port 9110.

```

docker-machine create --driver virtualbox --virtualbox-boot2docker-url=file://${HOME}/.docker/machine/cache/boot2docker.iso
