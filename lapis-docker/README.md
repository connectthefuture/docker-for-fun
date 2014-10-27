docker-lapis
============

This image aims to provide a clean docker base image for the latest version of the Lapis Lua web framework (backed by OpenResty).

OpenResty is installed at `/opt/openresty`. To use this image, place your Lapis application files in `/opt/openresty/nginx/conf`.                  
step1:                  
sudo docker build -t edwin/lapis -< Dockerfile                       
step2:                       
sudo docker run -i -t  -p 2222:8080 edwin/lapis /bin/bash                      
step3:                     
cd  /opt/openresty/nginx/conf                        
step4:                
rm nginx.conf                   
step5:                  
lapis new --lua                   
step6:                  
 LAPIS_OPENRESTY=/opt/openresty/nginx/sbin/nginx lapis server                     
step7:                 
在宿主机的浏览器中输入                                  
http://localhost:2222/                 
应该能看到如下内容                     
Welcome to Lapis 1.0.5                   

1.  [Creating a Lapis Application with Lua](http://leafo.net/lapis/reference/lua_getting_started.html)