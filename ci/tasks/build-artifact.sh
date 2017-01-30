#!/usr/bin/env bash
set -e

export GRADLE_OPTS=-Dorg.gradle.native=false
version=`cat version/number`
cd df-repo/${SUBPROJECT}
echo $version
./mvnw clean package -Djar.finalName=${SUBPROJECT}_${version}
pwd
ls target/.
cp target/${SUBPROJECT}_${version}.jar ../../build-output/.
