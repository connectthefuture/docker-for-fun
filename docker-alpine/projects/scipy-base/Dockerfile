FROM dc/alpine


ADD repositories /etc/apk/repositories
RUN apk update && apk upgrade && apk add --update \
  bash \
  python \
  python-dev \
  py-pip \
  g++ \
  libpng \
  libpng-dev \
  freetype \
  freetype-dev \
  postgresql-dev \
  py-numpy@testing \
  py-numpy-dev@testing \
  py-scipy@testing \
  py-scipy-dev@testing


RUN pip install --upgrade pip && pip install \
  scikit-learn \
  matplotlib
