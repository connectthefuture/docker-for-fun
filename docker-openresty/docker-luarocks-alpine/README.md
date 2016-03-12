## 创建镜像

````
docker build  -t edwin/openresty-luarocks-alpine  .
````

## 启动镜像

````
docker run --rm -it --name test edwin/openresty-alpine  /bin/sh
````

##  测试
在dockerfile所在目录下创建一个新的文件夹 供测试用
mkdir openresty-test

运行
 docker run --rm -it \
  --name my-app-dev \
  -v "$(pwd)/openresty-test":/opt/openresty/nginx/conf \
  -p 8080:8080 \
edwin/openresty-alpine "$@"


获取container 的ip
 ```
 docker inspect --format='{{.NetworkSettings.IPAddress}}' $CONTAINER_ID
 ➜  docker-for-fun git:(master) ✗ docker inspect --format='{{.NetworkSettings.IPAddress}}' 6da96
172.17.0.2
 ```

浏览器中访问如下地址即可
```
http://172.17.0.2:8080/
```
