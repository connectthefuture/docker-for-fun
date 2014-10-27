第一种情况    尝试openresty-clean下的Dockerfile构建image                                     
第一步   sudo docker build -t ="edwin/openresty"    - < Dockerfile                   
第二步 运行image  sudo docker run -t -i -p 8080:8080 -v=`pwd`:/openresty-clean -w=/openresty-clean edwin/openresty                     
这里使用-v -w来进行宿主机和container的目录映射，openresty-clean为我存放dockerfile的目录，也是我存放nginx.conf app.lua的目录
可以使用任意你自己的目录来替代
第三步 查看效果                  
 curl http://127.0.0.1:8080/             
第四步 修改app.lua的内容，比如       
    ngx.say('Hello World! 王八蛋')
    ngx.exit(200)
第五步  curl http://127.0.0.1:8080/             

第二种情况  尝试moochine-docker下的Dockerfile构建image                  
在moochine-docker目录下                
第一步                   
sudo docker build -t edwin/moochine-openresty   - < Dockerfile                  
第二步        在moochine-docker目录下          
sudo docker run -t -i -p 8080:8080 -v=`pwd`:/moochine-docker -w=/moochine-docker edwin/moochine-openresty                  
第三步             
第三步 查看效果                  
 curl http://127.0.0.1:8080/
更改helloproj/app.lua中的内容后 再次测试 无需重启nginx 即可看到更改后的结果


第三种，使用kdr2/debian:sid-moochine的image。
第一步，获取image
docker pull kdr2/debian:sid-moochine
第二步，启动image# run in attached docker container shell:
$ docker run -t -i -p 0.0.0.0:9801:9800 kdr2/debian:sid-moochine /bin/bash
第三步 启动moochine-demo的程序 
root@4df89d75e286:/# /root/moochine-demo/bin/start.sh
# 第三步 第二步合在一起
$ docker run -d -p 0.0.0.0:9801:9800 kdr2/debian:sid-moochine /root/moochine-demo/bin/start.sh -f
第四步，测试
curl  http://localhost:9801/ltp
curl "http://localhost:9801/hello?name=edwin"
