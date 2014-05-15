#!/bin/bash

yum groupinstall -y "Development Tools"
yum install -y git
yum install -y java-1.7.0-openjdk

if [ ! -d /vagrant/rpm/logstash-kafka ]; then
  git clone https://github.com/joekiller/logstash-kafka.git /vagrant/rpm/logstash-kafka
fi

cd /vagrant/rpm/logstash-kafka
make tarball LOGSTASH_VERSION=1.4.0 KAFKA_VERSION=0.8.1.1 SCALA_VERSION=2.9.2

tar xvfz build/logstash-1.4.0.tar.gz -C /tmp
cp -rf /tmp/logstash-1.4.0/* /opt/logstash/
rm -rf /tmp/logstash-1.4.0
