#!/bin/bash

rpm --import http://packages.elasticsearch.org/GPG-KEY-elasticsearch

echo "[logstash-1.4]
name=logstash repository for 1.4.x packages
baseurl=http://packages.elasticsearch.org/logstash/1.4/centos
gpgcheck=1
gpgkey=http://packages.elasticsearch.org/GPG-KEY-elasticsearch
enabled=1" > /etc/yum.repos.d/logstash.repo

yum install -y logstash

mkdir -p /var/logstash

case "$1" in
  "nginx")
    sed -e "s/\${REDIS_HOSTS}/$2/g" /vagrant/logstash/nginx-logstash.conf > /etc/logstash/conf.d/nginx-logstash.conf
    ;;
  "collector")
    sed -e "s/\${REDIS_HOST}/\"$2\"/g" /vagrant/logstash/logstash-collector.conf | sed -e "s/\${KAFKA_BROKERS}/\"$3\"/g" > /etc/logstash/conf.d/logstash-collector.conf
    ;;
esac
