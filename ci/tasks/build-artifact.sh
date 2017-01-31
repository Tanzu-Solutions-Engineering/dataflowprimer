#!/usr/bin/env bash
set -e

export GRADLE_OPTS=-Dorg.gradle.native=false
version=`cat version/number`
cd df-repo/${SUBPROJECT}
echo $version
./mvnw clean package -Djar.finalName=${SUBPROJECT}-${version}
pwd
ls target/.
cp target/${SUBPROJECT}-${version}.jar ../../build-output/.
