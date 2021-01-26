#!/bin/bash

MAXTESTS=$1
source env.sh

for i in $(seq 1 $MAXTESTS); do
	echo $i
	./start_docker.sh
	$CMSSW_BASE/bin/slc7_amd64_gcc900/client
	./stop_docker.sh
done
