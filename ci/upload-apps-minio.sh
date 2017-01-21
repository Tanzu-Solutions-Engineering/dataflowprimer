#!/bin/bash

export ACCESS_KEY="M18D8ZJE2C68L2Q7255K"
export SECRET_KEY="S9eO8bs7ZaW2Qk5USrChu0CG8Q2S748oPHlxsVFF"
export S3_ENDPOINT=http://192.168.0.106:9000
export SOURCE_APP_LOC=../sourcedemo/target/
export SOURCE_APP=sourcedemo-0.0.1-SNAPSHOT.jar
export SINK_APP=

mc config host add scdf-apps ${S3_ENDPOINT} ${ACCESS_KEY} ${SECRET_KEY} S3v4
mc mb scdf-apps/scdf-apps
mc cp ${SOURCE_APP_LOC}/${SOURCE_APP} scdf-apps/scdf-apps/
mc policy public scdf-apps/scdf-apps/${SOURCE_APP}
