#!/bin/bash

mkdir -p models/gat_test/1
cat << EOF > models/gat_test/config.pbtxt
name: "gat_test"
platform: "pytorch_libtorch"
max_batch_size: 0
input [
  {
    name: "x__0"
    data_type: TYPE_FP32
    dims: [ -1, 1433 ]
  },
  {
    name: "edgeindex__1"
    data_type: TYPE_INT64
    dims: [ 2, -1 ]
  }
]
output [
  {
    name: "logits__0"
    data_type: TYPE_FP32
    dims: [ -1, 7 ]
  }
]
EOF

cp triton/torch_geometric/examples/model.pt models/gat_test/1/model.pt

