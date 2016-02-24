## 创建镜像

````
docker build  -t edwin/vanilla-openresty-alpine  .
````

## 启动镜像

````
docker run -d -p 9110:9110 edwin/vanilla-openresty-alpine
````

 docker cp 451a8805df074275ecde46f1428ed123235e93592103fa18d1ab92a37530001b:/tmp/vdemo ./demo1 

docker run -t -i -v /home/edwin-clear/resources/sourceCode/docker-for-fun/docker-openresty/vanilla-alpine/demo1:/tmp/vdemo/  --name vanilladata  edwin/vanilla-openresty-alpine /bin/sh
docker run -d --volume-from --name vanilladata edwin/vanilla-openresty-alpine



docker run -t -i -v $(pwd)/demo1:/tmp/vdemo/ -w=/tmp/vdemo/  edwin/vanilla-openresty-alpine /bin/sh

docker run -t -i -v $(pwd)/demo1:/tmp/vdemo/ -w=/tmp/vdemo/  edwin/vanilla-openresty-alpine vanilla start