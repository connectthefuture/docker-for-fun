# Dockerfile for RAML API Designter
# Updated 20150430
FROM edwin/nodejs:0.11
MAINTAINER  wanghaisheng <edwin_uestc@163.com>

RUN mkdir -p /raml-editor
RUN chown -R `whoami` /raml-editor

ADD ./api-designer  /raml-editor
WORKDIR /raml-editor
RUN sed -i 's/localhost/0.0.0.0/g' Gruntfile.js
RUN cnpm install -g grunt-cli
RUN cnpm install -g bower
RUN cnpm install
RUN bower install --allow-root

# Expose ports
EXPOSE 9013

CMD cd /raml-editor; grunt server -f
