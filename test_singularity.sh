#!/bin/bash

MAXTESTS=$1

for i in $(seq 1 $MAXTESTS); do
	echo $i
	./start_singularity.sh
	python3 client.py
	./stop_singularity.sh
done
