#!/usr/bin/env bash

killProcess() {
  pid=$(ps -ef | grep demo.jar | grep -v grep | awk '{print $2}')
  echo "Killing process $pid"
  if [ "$pid" = "" ]; then
    echo "No process found"
  else
    kill -9 $pid
  fi
}

cd $PROJ_PATH/demo
mvn clean package

killProcess

mv $DEPLOY_PATH/demo.jar $DEPLOY_PATH/backup/demo_$(date +%Y%m%d%H%M).jar
cp $PROJ_PATH/demo/target/demo-0.0.1-SNAPSHOT.jar $DEPLOY_PATH/demo.jar

cd $DEPLOY_PATH
nohup java -jar demo.jar &
