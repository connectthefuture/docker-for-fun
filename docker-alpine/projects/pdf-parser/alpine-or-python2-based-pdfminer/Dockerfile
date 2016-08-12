FROM dc/openresty-alpine

#  docker build -t dc/alpine-or-python2-pdfminer .
RUN apk update && apk upgrade

RUN apk add python git 

# Clean APK cache
RUN rm -rf /var/cache/apk/*

RUN cd /tmp &&  git clone https://github.com/euske/pdfminer && \
   cd pdfminer && python setup.py install 


CMD ["nginx", "-g", "daemon off; error_log /dev/stderr info;"]