#!/usr/bin/env bash
set -e

cd df-repo/${SUBPROJECT}
./mvnw --version
./mvnw test
