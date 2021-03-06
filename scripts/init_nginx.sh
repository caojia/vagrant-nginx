#!/bin/bash

if [ ! -f "/vagrant/rpm/nginx-release-centos-6-0.el6.ngx.noarch.rpm" ]; then
  wget "http://nginx.org/packages/centos/6/x86_64/RPMS/nginx-1.6.0-1.el6.ngx.x86_64.rpm" -P /vagrant/rpm
  wget "http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm" -P /vagrant/rpm

  rpm -ivh /vagrant/rpm/nginx-release-centos-6-0.el6.ngx.noarch.rpm
fi

yum install -y nginx
chkconfig nginx on

# don't do system logrotate for nginx
rm -rf /etc/logrotate.d/nginx

ulimit -n 10240

cp -f /vagrant/nginx/nginx.conf /etc/nginx/
service nginx restart

cp -f /vagrant/nginx/nginx-cron /etc/cron.d/
service crond restart
