第一种情况  只是通过根目录下的Dockerfile构建image                        
在根目录下                      
第一步   sudo docker build -t="torhve/openresty"    - < Dockerfile.                  
第二步 运行image  sudo docker run -t -i -p 8080:8080 -v=`pwd`:/helloproj -w=/helloproj edwin/openresty                     
第三步 查看效果                  
 curl http://127.0.0.1:8080/                    

第二种情况  尝试moochine-docker下的Dockerfile构建image                  
在moochine-docker目录下                
第一步                   
sudo docker build -t edwin/moochine-openresty   - < Dockerfile                  
第二步        在helloproj目录下          
sudo docker run -t -i -p 8080:8080 -v=`pwd`:/helloproj -w=/helloproj edwin/moochine-openresty                  
第三步             
第三步 查看效果                  
 curl http://127.0.0.1:8080/
更改helloproj/app.lua中的内容后 再次测试 无需重启nginx 即可看到更改后的结果



第二步        在moochine-demo 目录下          
sudo docker run  -t -i -p 9800:9800 -v=`pwd`:/moochine-demo -w=/moochine-demo  edwin/moochine-openresty
不成功


