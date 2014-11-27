docker-predictionio
===================

Run [PredictionIO](http://prediction.io) inside Docker
在宿主机上执行以下命令，启动PredictionIO，亦可直接运行文件中的命令。
1. Run ```build``` to build the image
2. Run ```shell``` to start the container
3. Once inside the container, run ```runsvdir-start&``` to start everything
4. The Dashboard is available on port 9000

PredictionIO启动之后，进入container的console，执行如下命令
Run [quickstart](http://docs.prediction.io/0.8.2/recommendation/quickstart.html)

1. Go to quickstartapp directory ```cd /quickstartapp```
2. Build and Train Engine ```./run.sh```
3. Deploy Engine ```cd MyRecommendation && pio deploy --ip 0.0.0.0&```
4. Your Engine will now listen on port 8000


测试结果
$ curl -H "Content-Type: application/json" -d '{ "user": 1, "num": 4 }' http://localhost:8000/queries.json

{"productScores":[{"product":22,"score":4.072304374729956},{"product":62,"score":4.058482414005789},{"product":75,"score":4.046063009943821},{"product":68,"score":3.8153661512945325}]}


参考[    Python SDK    PHP SDK    Ruby SDK   Java SDK    REST API](http://docs.prediction.io/0.8.2/recommendation/quickstart.html)