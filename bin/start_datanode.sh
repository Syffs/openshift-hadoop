#!/bin/bash

mkdir -p ${DATA_DIR}/hdfs/namenode
mkdir -p ${DATA_DIR}/hdfs/datanode

cp $HADOOP_INSTALL/etc/hadoop/core-site-slave.xml $HADOOP_INSTALL/etc/hadoop/core-site.xml

echo *************************
#echo "HADOOP ADRESS ${HADOOP_NAMENODE_ADDRESS}"
#NAMENODE_IP=${HADOOP_NAMENODE_ADDRESS}
NAMENODE_IP=`curl -H "Authorization: Bearer $(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" -k -XGET "https://openshift.default.svc.cluster.local/api/v1/namespaces/${POD_NAMESPACE}/pods?labelSelector=name=${HADOOP_NAMENODE_ADDRESS}" | grep podIP | sed -e 's/.*"podIP": "\(.*\)".*/\1/'`
#NAMENODE_IP=`curl -H "Authorization: Bearer $(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" -k -XGET "https://openshift.default.svc.cluster.local/api/v1/namespaces/${POD_NAMESPACE}/pods?labelSelector=name=hadoop-namenode" | grep podIP | sed -e 's/.*"podIP": "\(.*\)".*/\1/'`
echo NAMENODE ${NAMENODE_IP}
echo *************************

HOST_IP=`ip -o -4 -r a | grep eth0 | sed -e 's/.*inet \([^/]*\).*/\1/'`
#sed -i -e"s/<ip>/namenode/" $HADOOP_INSTALL/etc/hadoop/core-site.xml
sed -i -e"s/<namenode_ip>/${NAMENODE_IP}/" $HADOOP_INSTALL/etc/hadoop/core-site.xml
sed -i -e"s/<ip>/${HOST_IP}/g" $HADOOP_INSTALL/etc/hadoop/hdfs-site.xml

exec hdfs datanode

