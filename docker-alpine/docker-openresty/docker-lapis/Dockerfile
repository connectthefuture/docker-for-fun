FROM ubuntu:14.04
MAINTAINER  wanghaisheng <edwin_uestc@163.com>

RUN apt-get -qq update
# install build dependencies
RUN apt-get -qqy install libreadline-dev libncurses5-dev libpcre3-dev libssl-dev perl make curl git-core

# build/install OpenResty
ENV SRC_DIR /opt
ENV OPENRESTY_VERSION 1.7.4.1
ENV OPENRESTY_PREFIX /opt/openresty
ENV LAPIS_VERSION 1.0.5

RUN cd $SRC_DIR && curl -LO http://openresty.org/download/ngx_openresty-$OPENRESTY_VERSION.tar.gz \
 && tar xzf ngx_openresty-$OPENRESTY_VERSION.tar.gz && cd ngx_openresty-$OPENRESTY_VERSION \
 && ./configure --prefix=$OPENRESTY_PREFIX \
 --with-luajit \
 --with-http_realip_module \
 && make && make install && rm -rf ngx_openresty-$OPENRESTY_VERSION*

RUN apt-get -qqy install luarocks
RUN luarocks install lapis

# Unset ENV
RUN unset SRC_DIR OPENRESTY_VERSION OPENRESTY_PREFIX LAPIS_VERSION

WORKDIR $OPENRESTY_PREFIX/nginx/conf

CMD LAPIS_OPENRESTY=/opt/openresty/nginx/sbin/nginx lapis server production
