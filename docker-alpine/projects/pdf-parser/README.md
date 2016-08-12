docker run  -d   --name pdf-miner-service   -v "$(pwd)/pdf-miner-http-api-based-or:/opt/openresty/nginx/conf"   -p 8070:8080 dc/alpine-or-python2-pdfminer  "$@"
