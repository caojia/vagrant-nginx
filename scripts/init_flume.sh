#/bin/bash

yum install -y git

if [ ! -f /etc/yum.repos.d/cloudera-cdh4.repo ]; then
  cp /vagrant/flume/cloudera-cdh4.repo /etc/yum.repos.d/
fi

yum install -y flume-ng

mkdir -p /usr/local/flume/plugins/lib
cp -r /vagrant/flume/*.jar /usr/local/flume/plugins/lib
chown -R flume:flume /usr/local/flume

sed -e "s/\${KAFKA_BROKERS}/$1/g" /vagrant/flume/nginx-flume.conf > /etc/flume-ng/conf/flume.conf

flume-ng agent -n NginxKafka -f /etc/flume-ng/conf/flume.conf --plugins-path /usr/local/flume
