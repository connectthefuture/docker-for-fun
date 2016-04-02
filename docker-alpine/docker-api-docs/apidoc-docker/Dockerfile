# Dockerfile for apidoc
# Updated 20150604
FROM edwin/nodejs:0.11
MAINTAINER  wanghaisheng <edwin_uestc@163.com>

RUN mkdir -p /example  && mkdir -p /doc
RUN chown -R `whoami` /example && chown -R `whoami` /doc

# Install apidoc
RUN  cnpm install -g apidoc

ADD ./example  /example
WORKDIR /example
EXPOSE 9014
CMD [ "/bin/bash" ]

# apidoc -i  /example/ -o  /doc/
