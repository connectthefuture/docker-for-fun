FROM edwin/openresty-alpine

ENV OPENRESTY_VERSION 1.9.7.3
ENV OPENRESTY_PREFIX /opt/openresty
ENV VANILLA_VERSION V0.1.0-rc4.0 
ENV VANILLA_PREFIX /usr/local/vanilla

ENV OPENRESTY_BUILD_DEPS "make gcc  curl perl"

ENV PYTHON_VERSION=2.7.11-r3
ENV PY_PIP_VERSION=7.1.2-r0
ENV SUPERVISOR_VERSION=3.2.0

RUN apk update && apk add -u python=$PYTHON_VERSION py-pip=$PY_PIP_VERSION
RUN pip install supervisor==$SUPERVISOR_VERSION

RUN apk update \
  && apk add --virtual tmp-build-deps $OPENRESTY_BUILD_DEPS  \
  && cd /tmp \
  && curl -sSL https://github.com/idevz/vanilla/archive/${VANILLA_VERSION}.tar.gz | tar -xvz \
  && cd vanilla-0.1.0-rc4.0 \
  && ./configure --prefix=$VANILLA_PREFIX --openresty-path=$OPENRESTY_PREFIX \
  && make install 
ADD ./supervisord.conf /etc/
RUN mkdir -p /var/log/supervisor 
#RUN mkdir -p /tmp/vdemo
#ADD ./demo1 /tmp/vdemo
#RUN cd /tmp && vanilla new vdemo
EXPOSE 9110
#RUN cd /tmp/vdemo/ 
CMD ["/usr/bin/supervisord"]
#ENTRYPOINT  ["vanilla", "start"] 