openresty
-----------------------------------------------                 


尝试openresty-clean下的Dockerfile构建image                                     
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