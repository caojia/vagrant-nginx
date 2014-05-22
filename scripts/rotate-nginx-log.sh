#!/bin/bash

log_file=$1

if [ -f $log_file ]; then
  file_size=$(stat -c "%s" $log_file)

  if [ "$file_size" != "0" ]; then
    log_dir=$(dirname $1)
    base_name=$(basename $1)
    time=$(date "+%Y%m%d%H%M%S")
    mkdir -p "$log_dir/archive"
    new_log_file="$log_dir/archive/$base_name""_$time.log"
    mv $log_file $new_log_file
    [ -f /var/run/nginx.pid ] && kill -USR1 `cat /var/run/nginx.pid`
  fi
fi
