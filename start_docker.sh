#!/bin/bash

source common.sh

docker run -d --name ${SERVER} --shm-size=1g --ulimit memlock=-1 --ulimit stack=67108864 -p8003:8003 -p8004:8004 -p8005:8005 -v$(readlink -f models):/models ${IMAGE} tritonserver --http-port=8000 --grpc-port=8001 --metrics-port=8002 --model-repository=/models --log-verbose=1 --log-error=1 --log-info=1

COUNT=0
while ! docker logs ${SERVER} |& grep -q "$STARTED"; do
	if [ "$COUNT" -gt "$WTIME" ]; then
		echo "timed out waiting for server to start"
		./stop_docker.sh
		exit 1
	else
		COUNT=$((COUNT+1))
		sleep 1
	fi
done
echo "server is ready!"
