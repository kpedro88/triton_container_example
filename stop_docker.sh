#!/bin/bash

source common.sh

docker logs ${SERVER} >& ${LOG}
docker stop ${SERVER}
docker rm ${SERVER}

