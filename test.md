运行image
 sudo docker run -t -i -p 8080:8080 -v=`pwd`:/helloproj -w=/helloproj edwin/openresty

查看效果
 curl http://127.0.0.1:8080/
