FROM alpine:latest
MAINTAINER WangXian <xian366@126.com>

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/' /etc/apk/repositories

WORKDIR /app
VOLUME /app
COPY startup.sh /startup.sh

RUN apk add --update mysql mysql-client && rm -f /var/cache/apk/*
COPY my.cnf /etc/mysql/my.cnf

EXPOSE 3306
CMD ["/startup.sh"]
