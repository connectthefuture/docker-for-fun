FROM edwin/alpine-oraclejdk8
MAINTAINER giabar 

ENV KAFKA_VERSION="0.9.0.1" SCALA_VERSION="2.11"
ADD download-kafka.sh /tmp/download-kafka.sh

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/' /etc/apk/repositories

RUN apk add --update \
    unzip \
    wget \
    curl \
    jq \
    coreutils && \
    /tmp/download-kafka.sh && \
    tar xfz /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt && \
    rm /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz
VOLUME ["/kafka"]
VOLUME ["/opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}"]
ENV KAFKA_HOME /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}
ADD start-kafka.sh /usr/bin/start-kafka.sh
CMD ["start-kafka.sh"]
EXPOSE 2181 9092
