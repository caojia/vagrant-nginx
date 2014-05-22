vagrant-nginx
=============
启动一个nginx虚拟机，将nginx中的Log通过Flume通道发送至Kafka。

原理
=============
1. flume-spool-directory: monitor一个文件夹，将这个文件夹中的新文件按行parse，放入Flume通道；https://github.com/xlvector/flume
2. flume-kafka-sink: 从Flume通道中读取事件，并发送给Kafka；https://github.com/caojia/flume-kafka-sink
3. rotate-nginx-log.sh: 将nginx的log移入一个新的文件夹，并让nginx重新打开log

其它分支
=============
nginx-logstash是使用logstash作为通道发送至Kafka的branch。

依赖
=============
该项目中用到的Kafka均依赖于https://github.com/caojia/vagrant-kafka 的配置。
