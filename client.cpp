#include "grpc_client.h"

#include <string>
#include <sstream>
#include <vector>
#include <random>
#include <iostream>
#include <algorithm>
#include <exception>

namespace ni = nvidia::inferenceserver;
namespace nic = ni::client;

//helper to turn triton error into exception
void throwIfError(const nic::Error& err, const std::string& msg) {
	if (!err.IsOk()) {
		std::stringstream smsg;
		smsg << "TritonServerFailure: " << msg << ": " << err;
		throw std::runtime_error(smsg.str());
	}
}

int main(){
	int64_t xdim(1433);
	int64_t edim(2);
	std::string oname("logits__0");

	std::unique_ptr<nic::InferenceServerGrpcClient> client;
	throwIfError(nic::InferenceServerGrpcClient::Create(&client, "0.0.0.0:8001", false), "unable to create inference context");
	nic::InferOptions options("gat_test");

	std::mt19937 rng(1);
	for (int i = 0; i < 3; ++i) {
		std::uniform_int_distribution<int64_t> randint1(1, 10);
		auto nnodes = randint1(rng);
		std::uniform_int_distribution<int64_t> randint2(20, 40);
		auto nedges = randint2(rng);

		std::vector<nic::InferInput*> inputs(2);
		nic::InferInput::Create(&inputs[0], "x__0", {nnodes, xdim}, "FP32");
		nic::InferInput::Create(&inputs[1], "edgeindex__1", {edim, nedges}, "INT64");

		std::vector<float> data0(nnodes*xdim);
		std::normal_distribution<float> randx(-10, 4);
		std::generate(data0.begin(), data0.end(), [&](){ return randx(rng); });
		inputs[0]->AppendRaw(reinterpret_cast<const uint8_t*>(data0.data()), data0.size() * sizeof(float));

		std::vector<int64_t> data1(edim*nedges);
		std::uniform_int_distribution<int64_t> randedge(0, nnodes - 1);
		std::generate(data1.begin(), data1.end(), [&](){ return randedge(rng); });
		inputs[1]->AppendRaw(reinterpret_cast<const uint8_t*>(data1.data()), data1.size() * sizeof(int64_t));

		std::vector<nic::InferRequestedOutput*> outputs(1);
		nic::InferRequestedOutput::Create(&outputs[0], oname);
		nic::InferResult* results;
		throwIfError(client->Infer(&results, options, inputs, {outputs[0]}), "unable to run and/or get result");

		const uint8_t* r0;
		size_t contentByteSize;
		results->RawData(oname, &r0, &contentByteSize);
		const float* r1 = reinterpret_cast<const float*>(r0);

		std::vector<int64_t> shape;
		results->Shape(oname, &shape);
		std::stringstream msg;
		for (int i = 0; i < shape[0]; ++i) {
			msg << "output " << i << ": ";
			for (int j = 0; j < shape[1]; ++j) {
				msg << r1[shape[1] * i + j] << " ";
			}
			msg << "\n";
		}
		std::cout << msg.str() << std::endl;
	}
}
