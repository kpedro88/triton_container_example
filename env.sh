#!/bin/bash

export PY3VER=$(python3 -c 'import sys; print("{}.{}".format(sys.version_info.major,sys.version_info.minor))')
export PYTHONPATH=$PWD/.local/lib/python${PY3VER}/site-packages/:$PWD/.local/lib64/python${PY3VER}/site-packages/:$PYTHONPATH
export PATH=$PWD/.local/bin:$PATH
