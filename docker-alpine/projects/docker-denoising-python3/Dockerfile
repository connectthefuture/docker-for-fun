#docker build -t dc/denoising .
# docker run --rm  --name denoising-remove-background -it -v /home/wanghs/dockerfiles-repo/docker-for-fun/docker-alpine/projects/:/tmp dc/denoising  /bin/sh

FROM alpine:3.4

ADD repositories /etc/apk/repositories

# add python requirements
ADD requirements.txt /requirements.txt

ENV NUMPY_VERSION 1.11.0
ENV PANDAS_VERSION 0.18.1
ENV MATPLOT_VERSION 1.5.1

# Install python related packages
RUN apk add --no-cache python3-dev && \
    apk add --no-cache libstdc++ && \
    apk add --no-cache --virtual .build-deps g++ && \
    ln -s /usr/include/locale.h /usr/include/xlocale.h && \
    apk add --no-cache postgresql-dev && \
    apk add --no-cache mariadb-dev && \
    apk add --no-cache freetype-dev && \
    pip3 --no-cache-dir install  -i https://pypi.tuna.tsinghua.edu.cn/simple -r /requirements.txt && \
    pip3 install  -i https://pypi.tuna.tsinghua.edu.cn/simple numpy==$NUMPY_VERSION && \
    pip3 install  -i https://pypi.tuna.tsinghua.edu.cn/simple pandas==$PANDAS_VERSION && \
    pip3 install  -i https://pypi.tuna.tsinghua.edu.cn/simple matplotlib==$MATPLOT_VERSION && \
    pip3 --no-cache-dir install  -i https://pypi.tuna.tsinghua.edu.cn/simple jupyter && \
    apk del .build-deps && \
    rm -rf /tmp/glibc*apk /var/cache/apk/* /root/.cache/pip && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    ln -s /usr/bin/pip3 /usr/bin/pip && \
    mkdir /notebooks


RUN  cd /tmp && \
     git clone https://github.com/scipy/scipy.git && \
     cd scipy && \
     git clean -xdf && \
     python setup.py install --user
# Install the jupyter notebook
VOLUME /notebooks
EXPOSE 8888

CMD ["sh", "-c", "jupyter notebook --no-browser --ip=* --notebook-dir=/notebooks"]

