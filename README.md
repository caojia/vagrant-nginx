vagrant-nginx
=============

启动一个nginx虚拟机，将nginx中的Log通过Logstash发送至Kafka。

模块
=============
logstash: http://logstash.net/, 使用File input，Redis output，Redis output，Kafka output
redis: http://redis.io/，缓存log通道
logstash-kafka: https://github.com/joekiller/logstash-kafka 将logstash中的event发送至Kafka

问题
=============
logstash的file input会用一个timer不断的poll某个文件夹下的文件修改，并且将当前的checkpoint写至sincedb文件中；但是，该checkpoint的持久化不是后台线程执行的，也不是每条执行，必须等到有新的文件修改并且距离上次持久化达到一定阈值时才会触发；所以可能会遇到一个问题：如果在短时间内，有大量写入，但之后又没有写入了，会使得checkpoint一直没有持续化；如果此时logstash重启，那么，会产生大量重复数据。

**修改方案**

可以在filewatcher库中，加入一个timer，进行持久化；注意：如果这样，就需要在持久化的时候加锁。
