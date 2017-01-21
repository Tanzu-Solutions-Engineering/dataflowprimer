#!/bin/bash

sh upload-apps-minio.sh
sh push-df-server-pcfdev.sh
echo "pausing 20s  while Dataflow server instance starts...."
sleep 20

java -jar spring-cloud-dataflow-shell-1.1.2.RELEASE.jar --spring.shell.commandFile=stream-definitions.txt --dataflow.uri=http://df-mwright.local.pcfdev.io

if [ $? -eq 1 ]
then
  echo "Stream create failed."
fi

echo "pausing for 60s while the test stream initializes itself..."
sleep 60
cf logs dataflow-server-test1-log --recent
sh cleanup.sh
