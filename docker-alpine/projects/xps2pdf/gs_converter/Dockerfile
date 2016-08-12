From ubuntu:15.10

# docker build -t dc/gs .

ADD sources.list /etc/apt/sources.list
RUN apt-get -y update && apt-get install -y wget  libxext-dev libxt-dev  && \
    wget  https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs919/ghostpdl-9.19.tar.bz2 && \
    tar xvvjf ghostpdl-9.19.tar.bz2 && \
    cd ghos* && \
    make xps
ADD . /tmp

