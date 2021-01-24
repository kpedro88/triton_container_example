#!/bin/bash

source common.sh

mkdir -p .${SERVER}/lib
ln -s $(readlink -f ${SANDBOX}/opt/tritonserver/lib/libtritonserver.so) $(readlink -f ${SANDBOX}/opt/tritonserver/lib/python) $(readlink -f ${SANDBOX}/opt/tritonserver/lib/pytorch) .${SERVER}/lib/
singularity instance start -B /dev/shm:/run/shm -B $(readlink -f $PWD) -B $(readlink -f .${SERVER}/lib):/opt/tritonserver/lib -B $(readlink -f models):/models ${SANDBOX}/ ${SERVER}
singularity run instance://${SERVER} tritonserver --http-port=8000 --grpc-port=8001 --metrics-port=8002 --model-repository=/models --log-verbose=1 --log-error=1 --log-info=1 >& ${LOG} &

COUNT=0
while ! grep -q "$STARTED" ${LOG}; do
	if [ "$COUNT" -gt "$WTIME" ]; then
		echo "timed out waiting for server to start"
		./stop_singularity.sh
		exit 1
	else
		COUNT=$((COUNT+1))
		sleep 1
	fi
done
echo "server is ready!"
