#!/bin/bash

MAXTESTS=$1

for i in $(seq 1 $MAXTESTS); do
	echo $i
	./start_singularity.sh
	$CMSSW_BASE/bin/slc7_amd64_gcc900/client
	./stop_singularity.sh
done
