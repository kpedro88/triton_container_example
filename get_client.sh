#!/bin/bash

HOME=$PWD python3 -m pip install --user --upgrade pip
.local/bin/pip install --prefix .local nvidia-pyindex
.local/bin/pip install --prefix .local tritonclient[all]

