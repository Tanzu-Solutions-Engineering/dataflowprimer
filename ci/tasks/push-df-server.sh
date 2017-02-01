#!/bin/bash

wget http://repo.spring.io/snapshot/org/springframework/cloud/spring-cloud-dataflow-server-cloudfoundry/1.2.0.BUILD-SNAPSHOT/spring-cloud-dataflow-server-cloudfoundry-1.2.0.BUILD-SNAPSHOT.jar
wget http://repo.spring.io/release/org/springframework/cloud/spring-cloud-dataflow-shell/1.1.2.RELEASE/spring-cloud-dataflow-shell-1.1.2.RELEASE.jar

cf login -u ${USERNAME} -p ${PASSWORD} -o ${ORG} -s ${SPACE} -a ${API_ENDPOINT}

cf delete dataflow-server -r -f

cf delete-service df-mysql -f
cf create-service p-mysql 512mb df-mysql
 
#custom built SCDF server to enable PCF features
cf push dataflow-server -n df-mwright -m 2G -k 2G -b java_buildpack -u none -p spring-cloud-dataflow-server-cloudfoundry-1.2.0.BUILD-SNAPSHOT.jar --no-start
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_URL ${API_ENDPOINT}
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_ORG ${ORG}
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_SPACE ${SPACE}
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_DOMAIN ${DOMAIN}
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_STREAM_SERVICES df-rabbit
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_USERNAME ${USERNAME}
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_PASSWORD ${PASSWORD}
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_SKIP_SSL_VALIDATION true
cf set-env dataflow-server MAVEN_REMOTE_REPOSITORIES_REPO1_URL https://repo.spring.io/libs-snapshot
cf set-env dataflow-server MAVEN_REMOTE_REPOSITORIES_REPO2_URL https://repo.spring.io/libs-milestone
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_STREAM_BUILDPACK java_buildpack
cf set-env dataflow-server SPRING_CLOUD_DATAFLOW_FEATURES_EXPERIMENTAL_TASKSENABLED true
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_TASK_SERVICES df-mysql,df-rabbit
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_STREAM_API_TIMEOUT 500
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_STREAM_ENABLE_RANDOM_APP_NAME_PREFIX false
cf bind-service dataflow-server df-mysql
cf bind-service dataflow-server df-redis
cf start dataflow-server
