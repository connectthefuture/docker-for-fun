FROM edwin/openresty-alpine
ENV VERSION 2.2.2

WORKDIR /root
RUN apk update \
		&& apk add build-base gcc make curl automake autoconf tar \
		lua lua-dev --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
		&& apk upgrade \
		&& mkdir -m 777 -p /luarocks /lua \
		&& wget http://luarocks.org/releases/luarocks-${VERSION}.tar.gz \
		&& tar -zxvf luarocks-${VERSION}.tar.gz -C / \
		&& cd /luarocks-${VERSION} \
		&& ./configure; make bootstrap \
		&& luarocks install luasocket \
		&& apk del build-base gcc make curl automake autoconf tar \
		&& apk upgrade \
		&& rm -rf /var/cache/apk/* \
		&& cd /lua \
		&& rm -rf /luarocks \
		&& apk update

WORKDIR /lua
VOLUME /lua

CMD ["/bin/echo", "Base image!"]
