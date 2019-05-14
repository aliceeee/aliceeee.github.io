---
title: Kafka Client
date: 2019-04-26 16:55:41
tags:
    - kafka
    - java
    - client
categories:
    - Tech
---

<!-- more -->

# Java Client

## apache kafka-client

> 官方文档：https://kafka.apache.org/11/documentation.html#producerapi
>
> 官方java doc: https://kafka.apache.org/11/javadoc/overview-summary.html
>
> [Kafka Tutorial: Writing a Kafka Producer in Java](http://cloudurable.com/blog/kafka-tutorial-kafka-producer/index.html)
>
> [Kafka Producer配置解读](http://atbug.com/kafka-producer-config/)

### Example: Simple Producer Demo
pom.xml
```xml
<!-- https://mvnrepository.com/artifact/org.apache.kafka/kafka-clients -->
<dependency>
    <groupId>org.apache.kafka</groupId>
    <artifactId>kafka-clients</artifactId>
    <version>2.1.1</version>
</dependency>
```

```java
public class KafkaProducerExample {
    // ...
    private static Producer<Long, String> createProducer() {
        Properties props = new Properties();
        // ProducerConfig: https://kafka.apache.org/11/javadoc/index.html?org/apache/kafka/clients/producer/ProducerConfig.html
        props.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG,
                                            BOOTSTRAP_SERVERS);
        props.put(ProducerConfig.CLIENT_ID_CONFIG, "KafkaExampleProducer");
        props.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG,
                                        LongSerializer.class.getName());
        props.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG,
                                    StringSerializer.class.getName());
        
        // KafkaProducer： https://kafka.apache.org/11/javadoc/org/apache/kafka/clients/producer/KafkaProducer.html
        return new KafkaProducer<>(props);
    }

   static void runProducer(final int sendMessageCount) throws Exception {
      final Producer<Long, String> producer = createProducer();
      long time = System.currentTimeMillis();

      try {
          for (long index = time; index < time + sendMessageCount; index++) {
              final ProducerRecord<Long, String> record =
                      new ProducerRecord<>(TOPIC, index,
                                  "Hello Mom " + index);

              RecordMetadata metadata = producer.send(record).get();

              long elapsedTime = System.currentTimeMillis() - time;
              System.out.printf("sent record(key=%s value=%s) " +
                              "meta(partition=%d, offset=%d) time=%d\n",
                      record.key(), record.value(), metadata.partition(),
                      metadata.offset(), elapsedTime);

          }
      } finally {
          producer.flush();
          producer.close();
      }
  }

```



