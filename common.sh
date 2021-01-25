#!/bin/bash

export IMAGE=fastml/triton-torchgeo:20.09-py3-geometric
if [ -z "$SANDBOX" ]; then
	export SANDBOX=triton
fi
export SERVER=triton_server_instance
export LOG=log_${SERVER}.log
export STARTED="Started GRPCInferenceService"
export WTIME=120
