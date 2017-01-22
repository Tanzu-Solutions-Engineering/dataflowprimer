brew install sbt

cd /tmp
wget http://mirror.jax.hugeserver.com/apache/kafka/0.10.1.1/kafka_2.11-0.10.1.1.tgz
tar -zxvf kafka_2.11-0.10.1.1.tgz -C /usr/local/
cd /usr/local/kafka_2.11-0.10.1.1

sbt update
sbt package

cd /usr/local
ln -s kafka_2.11-0.10.1.1 kafka

echo "" >> ~/.bash_profile
echo "" >> ~/.bash_profile
echo "# KAFKA" >> ~/.bash_profile
echo "export KAFKA_HOME=/usr/local/kafka" >> ~/.bash_profile
source ~/.bash_profile

echo "export KAFKA=$KAFKA_HOME/bin" >> ~/.bash_profile
echo "export KAFKA_CONFIG=$KAFKA_HOME/config" >> ~/.bash_profile
source ~/.bash_profile

$KAFKA/zookeeper-server-start.sh $KAFKA_CONFIG/zookeeper.properties
$KAFKA/kafka-server-start.sh $KAFKA_CONFIG/server.properties
