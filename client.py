import numpy as np
import random
import tritonclient.grpc

triton_client = tritonclient.grpc.InferenceServerClient(url="0.0.0.0:8001")

model_name = "gat_test"
xdim = 1433
edim = 2

# inference
for i in range(3):
    inputs = []
    outputs = []
    nnodes = random.randint(1,10)
    nedges = random.randint(20,40)
    inputs.extend([
        tritonclient.grpc.InferInput('x__0', [nnodes, xdim], 'FP32'),
        tritonclient.grpc.InferInput('edgeindex__1', [edim, nedges], 'INT64'),
    ])
    x = np.clip(np.random.normal(-10, 4, (nnodes, xdim)).astype(np.float32), 0, 1)
    edge_index = np.random.randint(0, nnodes, (edim, nedges), dtype=np.int64)
    inputs[0].set_data_from_numpy(x)
    inputs[1].set_data_from_numpy(edge_index)
    outputs.extend([
        tritonclient.grpc.InferRequestedOutput('logits__0')
    ])
    results = triton_client.infer(model_name=model_name, inputs=inputs, outputs=outputs)
    output0_data = results.as_numpy('logits__0')
    print(output0_data)
