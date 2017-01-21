#!/bin/bash

java -jar spring-cloud-dataflow-shell-1.1.2.RELEASE.jar --spring.shell.commandFile=cleanup-streams.txt --dataflow.uri=http://df-mwright.local.pcfdev.io

echo "Pausing 10s to let dataflow server cleanup the test stream...."
sleep 10
cf delete dataflow-server -r -f
rm spring-cloud-dataflow-server-cloudfoundry*
rm spring-cloud-dataflow-shell*
