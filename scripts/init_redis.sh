#!/bin/bash

if [ ! -f /usr/local/bin/redis-server ]; then
  if [ ! -f /vagrant/rpm/redis-stable.tar.gz ]; then
    wget http://download.redis.io/redis-stable.tar.gz -P /vagrant/rpm -o /tmp/wget.log
  fi

  tar xvfz /vagrant/rpm/redis-stable.tar.gz -C /tmp
  cd /tmp/redis-stable
  make install

  mkdir -p /etc/redis
  mkdir -p /var/redis

  echo -e "\n\n\n\n/usr/local/bin/redis-server" | ./utils/install_server.sh
fi

PORT=6379
sed -e "s/\${PORT}/$PORT/g" /vagrant/redis/redis.conf > /etc/redis/$PORT.conf

service redis_$PORT restart
