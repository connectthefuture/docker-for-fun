	# Dockerfile for openresty
	# VERSION   0.0.3
	
	FROM ubuntu:14.04
	MAINTAINER edwin uestc <edwin_uestc@163.com>
	ENV REFRESHED_AT 2014-08-07
	
	ENV    DEBIAN_FRONTEND noninteractive
	RUN    echo "deb-src http://mirrors.163.com/ubuntu/  trusty main" >> /etc/apt/sources.list
	RUN    sed 's/main$/main universe/' -i /etc/apt/sources.list
	RUN    apt-get update
	RUN    apt-get upgrade -y
	RUN    apt-get -y install wget vim git libpq-dev
	
	# Openresty (Nginx)
	RUN    apt-get -y build-dep nginx \
	  && apt-get -q -y clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*
	RUN    wget http://openresty.org/download/ngx_openresty-1.5.12.1.tar.gz \
	  && tar xvfz ngx_openresty-1.5.12.1.tar.gz \
	  && cd ngx_openresty-1.5.12.1 \
	  && ./configure --with-luajit  --with-http_addition_module --with-http_dav_module --with-http_geoip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_realip_module --with-http_stub_status_module --with-http_ssl_module --with-http_sub_module --with-http_xslt_module --with-ipv6 --with-http_postgres_module --with-pcre-jit \
	  && make \
	  && make install \
	  && rm -rf /ngx_openresty*
	
	EXPOSE 8080
	CMD /usr/local/openresty/nginx/sbin/nginx -p `pwd` -c nginx.conf
	RUN    mkdir -p /opt \
	&&	cd /opt   \
	&&    	git clone git://github.com/appwilldev/moochine.git  \
	&&     	 export OPENRESTY_HOME=/usr/local/openresty  \
	&&	export MOOCHINE_HOME=/opt/moochine   \
	&&    	git clone git://github.com/appwilldev/moochine-demo.git  \

	&&    	cd moochine-demo   \
	&&	PWD= 'pwd'	  \
	&&         echo  $PWD  \

	&&    NGINX_FILES=$PWD"/nginx_runtime"  \

	&&    mkdir -p $NGINX_FILES"/conf"  \
	&&    mkdir -p $NGINX_FILES"/logs"  \

	&&    cp $PWD"/conf/mime.types" $NGINX_FILES"/conf/"  \

	&&    sed -e "s|__MOOCHINE_HOME_VALUE__|$MOOCHINE_HOME|" \
	    -e "s|__MOOCHINE_APP_PATH_VALUE__|$PWD|" \
	    $PWD/conf/nginx.conf > $NGINX_FILES/conf/p-nginx.conf  \

	&&    $OPENRESTY_HOME/nginx/sbin/nginx -p $NGINX_FILES/ -c conf/p-nginx.conf  \
	
	&&    echo "nginx started!"

