#/bin/bash

yum install -y git

if [ ! -f /etc/yum.repos.d/cloudera-cdh4.repo ]; then
  cp /vagrant/flume/cloudera-cdh4.repo /etc/yum.repos.d/
fi

yum install -y flume-ng

mkdir -p /usr/local/flume/plugins/lib
cp -r /vagrant/flume/*.jar /usr/local/flume/plugins/lib
chown -R flume:flume /usr/local/flume

mkdir -p /var/lib/flume-ng/file-channel/checkpoint
mkdir -p /var/lib/flume-ng/file-channel/backup-checkpoint
mkdir -p /var/lib/flume-ng/file-channel/data

sed -e "s/\${KAFKA_BROKERS}/$1/g" /vagrant/flume/nginx-flume.conf > /etc/flume-ng/conf/flume.conf

cp /vagrant/flume/initd_flume-agent /etc/init.d/flume-ng-agent
chkconfig --add flume-ng-agent
chkconfig flume-ng-agent on
service flume-ng-agent restart
