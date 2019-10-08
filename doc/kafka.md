## Configure kafka

### Use SASL/PLAIN

Ref: https://kafka.apache.org/documentation/#security_sasl_plain

### Add a pair of username and password

A new pair of username and password can be added in config/kafka_server_jaas.conf

### The configurations in config/client-ssl.properties should be like below:

```
sasl.mechanism=PLAIN
security.protocol=SASL_SSL
ssl.truststore.location=<path-to-server-truststore-jks>
ssl.truststore.password=<password>
ssl.endpoint.identification.algorithm=

# Change username and password based on your need.
sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required \
    username="admin" \
    password="<admin-password>";
```

## Topic

### Create a topic

```
./bin/kafka-topics.sh --zookeeper localhost:2181 --create --topic chubbstaging --partitions 1 --replication-factor 1 --config max.message.bytes=64000 --config flush.messages=1
```

### Show a topic

```
# --zookeeper option is deprecated
./bin/kafka-topics.sh --zookeeper localhost:2181 --describe --topic topic_name

BOOTSTRAP_SERVER=localhost:9093
./bin/kafka-topics.sh --bootstrap-server $BOOTSTRAP_SERVER --command-config ./config/client-ssl.properties --describe --topic topic_name
```

### List topics

```
./bin/kafka-topics.sh --bootstrap-server $BOOTSTRAP_SERVER --command-config ./config/client-ssl.properties --list
```

### Delete a topic

```
./bin/kafka-topics.sh --bootstrap-server $BOOTSTRAP_SERVER --command-config ./config/client-ssl.properties --delete --topic topic_name
```

## ACLs

### List ACLs

```
./bin/kafka-acls.sh --authorizer-properties zookeeper.connect=127.0.0.1:2181 --list
```

### Allow a user to produce messages to a topic

```
USER=username
TOPIC=topic
./bin/kafka-acls.sh --authorizer-properties zookeeper.connect=localhost:2181 --add --allow-principal User:$USER --producer --topic $TOPIC
```

### Allow a user to consume messages from a topic

```
USER=username
TOPIC=topic
GROUP=kafka-consumer-group-medimpact-staging
./bin/kafka-acls.sh --authorizer-properties zookeeper.connect=localhost:2181 --add --allow-principal User:$USER --consumer --topic $TOPIC --group $GROUP
```

## Consumer

```
./bin/kafka-console-consumer.sh --from-beginning --bootstrap-server $BOOTSTRAP_SERVER --topic $TOPIC  --consumer.config config/client-ssl.properties
./bin/kafka-console-consumer.sh --from-beginning --bootstrap-server $BOOTSTRAP_SERVER --topic $TOPIC  --consumer.config config/client-ssl.properties --group $GROUP
```

## Producer

```
./bin/kafka-console-producer.sh --broker-list $BOOTSTRAP_SERVER --topic $TOPIC --producer.config config/client-ssl.properties
```