#!/bin/bash

source common.sh
singularity build --sandbox ${SANDBOX}/ docker://${IMAGE}
