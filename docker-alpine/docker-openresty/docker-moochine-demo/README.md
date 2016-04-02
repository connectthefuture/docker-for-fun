https://github.com/wanghaisheng/moochine-demo
docker pull kdr2/debian:sid-moochine
# run in attached docker container shell:
$ docker run -t -i -p 0.0.0.0:9801:9800 kdr2/debian:sid-moochine /bin/bash
root@4df89d75e286:/# /root/moochine-demo/bin/start.sh
# or in a detached dcoker container:
$ docker run -d -p 0.0.0.0:9801:9800 kdr2/debian:sid-moochine /root/moochine-demo/bin/start.sh -f



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