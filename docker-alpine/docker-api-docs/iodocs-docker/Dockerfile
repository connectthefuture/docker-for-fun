# Dockerfile for iodocs
# Updated 20150604
FROM edwin/nodejs
RUN mkdir -p /iodocs
RUN chown -R `whoami` /iodocs
ADD . /iodocs
WORKDIR /iodocs
RUN chown -R `whoami` /usr/local/lib/node_modules
EXPOSE 3000
RUN apt-get install -y redis-server
RUN chown -R `whoami` /etc/redis/redis.conf
CMD redis-server /etc/redis/redis.conf  && cd /iodocs && npm install  && npm start  && bash
