FROM java:8-jdk

MAINTAINER John Erik Halse

# set java environment variable 
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64 
ENV PATH $PATH:$JAVA_HOME/bin
ENV HADOOP_INSTALL /usr/local/hadoop
ENV HADOOP_HOME=$HADOOP_INSTALL

ENV PATH ${PATH}:${HADOOP_INSTALL}/bin
ENV PATH ${PATH}:${HADOOP_INSTALL}/sbin
ENV HADOOP_MAPRED_HOME=$HADOOP_INSTALL
ENV HADOOP_COMMON_HOME=$HADOOP_INSTALL
ENV HADOOP_HDFS_HOME=$HADOOP_INSTALL
ENV HADOOP_CONF_DIR=$HADOOP_INSTALL/etc/hadoop
ENV YARN_HOME=$HADOOP_INSTALL
ENV YARN_CONF_DIR=$HADOOP_INSTALL/etc/hadoop
ENV DATA_DIR=/var/hadoop

#RUN apt-get -y update &&\
#	apt-get -y install libnss-wrapper &&\
#	apt-get clean

ENV HADOOP_VERSION 2.7.3

#install hadoop
RUN curl -L http://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz \
      | tar -xzp -C /usr/local
#ADD hadoop-${HADOOP_VERSION}.tar.gz /usr/local/
RUN ln -s /usr/local/hadoop-${HADOOP_VERSION} ${HADOOP_INSTALL}

COPY etc/* $HADOOP_INSTALL/etc/hadoop/
COPY bin/* $HADOOP_INSTALL/bin/

RUN mkdir -p ${DATA_DIR} && \ 
    mkdir ${DATA_DIR}/logs
	
RUN chmod -R 777 $HADOOP_INSTALL/etc/hadoop/ &&\
	chmod -R 777 $DATA_DIR

RUN useradd -U -d $HADOOP_INSTALL hadoop && passwd -d hadoop

RUN chown -R hadoop.hadoop $HADOOP_INSTALL &&\
	chown -R hadoop.hadoop $DATA_DIR

USER hadoop

EXPOSE 22 7373 7946 9000 50010 50020 50070 50075 50090 50475 8030 8031 8032 8033 8040 8042 8060 8088 50060

