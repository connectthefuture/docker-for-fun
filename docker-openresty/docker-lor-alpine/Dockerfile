FROM edwin/openresty-alpine

ENV OPENRESTY_VERSION 1.9.7.3
ENV OPENRESTY_PREFIX /opt/openresty
ENV LOR_VERSION V0.0.7
ENV LOR_PREFIX /usr/local/LOR

ENV OPENRESTY_BUILD_DEPS "git"

ENV PYTHON_VERSION=2.7.11-r3
ENV PY_PIP_VERSION=7.1.2-r0
ENV SUPERVISOR_VERSION=3.2.0

RUN apk update && apk add -u python=$PYTHON_VERSION py-pip=$PY_PIP_VERSION
RUN pip install supervisor==$SUPERVISOR_VERSION

RUN apk update \
  && apk add --virtual tmp-build-deps $OPENRESTY_BUILD_DEPS  \
  && cd /tmp \
  && git clone https://github.com/sumory/lor  \
  && cd lor \
  && sh install.sh \
  && adduser -D -g '' -u 1000 nginx
#RUN ln -sf /opt/openresty/luajit/bin/luajit /usr/local/bin/luajit
RUN ln -sf /opt/openresty/luajit/bin/luajit /usr/bin/luajit


ADD ./supervisord.conf /etc/
RUN mkdir -p /var/log/supervisor 
#RUN mkdir -p /tmp/openresty-china
ADD ./openresty-china /tmp/openresty-china

#RUN cd /tmp && LOR new vdemo
EXPOSE 8888
RUN  cd /tmp && cd openresty-china
CMD ["/usr/bin/supervisord"]
#ENTRYPOINT  ["LOR", "start"] 