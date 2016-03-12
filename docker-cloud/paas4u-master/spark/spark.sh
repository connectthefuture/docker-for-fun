#!/bin/bash

set -x

MASTER_IP=192.168.33.10
SPARK_MASTER=mesos://zk://${MASTER_IP}:2181/mesos

SPARK_SRC=http://apache.mirror.rafal.ca/spark/spark-1.6.0
SPARK_DIR=spark-1.6.0-bin-hadoop2.6
SPARK_FILE=${SPARK_DIR}.tgz

# Get Spark and put it in HDFS
wget -q ${SPARK_SRC}/${SPARK_FILE}
tar xf ${SPARK_FILE}
#rm ${SPARK_FILE}

# Configure Spark
cd ${SPARK_DIR}
cd conf
cp spark-env.sh.template spark-env.sh
cat >> spark-env.sh <<EOF
export MESOS_NATIVE_LIBRARY=/usr/local/lib/libmesos.so
export SPARK_EXECUTOR_URI=http://${MASTER_IP}:9914/${SPARK_FILE}
export MASTER=${SPARK_MASTER}
export SPARK_LOCAL_IP=${MASTER_IP}
export SPARK_PUBLIC_DNS=${MASTER_IP}
EOF
