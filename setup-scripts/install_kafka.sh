#!/bin/sh

# Install kafka with Ambari API

if [ `ps -ef |  grep kafka.Kafk[a] | wc -l` -gt 0 ]
then
        echo "Detected Kafka is already running"
else
        echo "Kafka is down...restarting"
        exit 1
fi

echo "Creating twitter_events topic"
/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --create --zookeeper sandbox.hortonworks.com:2181 --replication-factor 1 --partitions 1 --topic twitter_events
/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --zookeeper sandbox.hortonworks.com:2181 --list
