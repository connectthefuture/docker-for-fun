FROM edwin/openresty-alpine

ENV OPENRESTY_VERSION 1.9.7.3
ENV OPENRESTY_PREFIX /opt/openresty
ENV LOR_VERSION V0.0.7
ENV LOR_PREFIX /usr/local/lor

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
  && rm -rf /lor \
  && adduser -D -g '' -u 1000 nginx

RUN ln -sf /opt/openresty/luajit/bin/luajit /usr/bin/luajit


#RUN apk --update add libuuid && rm -f /var/cache/apk/*  \
#&& ln -s /usr/lib/libuuid.so $OPENRESTY_PREFIX/lualib

RUN apk add --update build-base \
                     cmake \
                     gnutls \
                     gnutls-dev \
                     libstdc++ \
    && wget -O- http://downloads.sourceforge.net/project/libuuid/libuuid-1.0.3.tar.gz | tar xz \
        && cd libuuid-1.0.3 \
        && ./configure --prefix=$OPENRESTY_PREFIX/lualib \
        && make install \
        && cd .. \
        && rm -rf libuuid-1.0.3 \





ADD ./supervisord.conf /etc/
RUN mkdir -p /var/log/supervisor 


EXPOSE 8888
CMD ["/usr/bin/supervisord"]
ENTRYPOINT  ["lord", "start"] 