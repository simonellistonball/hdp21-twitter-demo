#Usage:
#./runkafkaproducer.sh - regular mode
#./runkafkaproducer.sh debug - this avoids streaming full JSON doc for ease of debugging

MODE=$1
if [ "$MODE" == "" ]
then
	MODE="nondebug"
fi

if [ `ps -ef |  grep kafka.Kafk[a] | wc -l` -gt 0 ]
then
	echo "Detected Kafka is already running"
else
	echo "Kafka is down...restarting"
	nohup /usr/hdp/current/kafka-broker/bin/kafka-server-start.sh /usr/hdp/current/kafka-broker/config/server.properties &
	sleep 5
fi


echo "Compiling jar..."
cd /root/hdp21-twitter-demo/kafkaproducer
rm -f producertest.jar
rm -rf classes/*
export CLASSPATH=/usr/hdp/current/kafka-broker/libs/\*:./\*
javac  -d classes *.java
jar -cvf producertest.jar -C classes/ .

echo "Fixing system time..."
service ntpd stop
ntpdate pool.ntp.org
service ntpd start

java  example.producer.TestProducer $MODE
