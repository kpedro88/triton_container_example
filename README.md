# Triton container example

Partially based on [triton-torchgeo-gat-example](https://github.com/lgray/triton-torchgeo-gat-example),
with elements from [cmssw:HeterogeneousCore/SonicTriton](https://github.com/cms-sw/cmssw/tree/master/HeterogeneousCore/SonicTriton).

## Environment setup

Do this every time:
```bash
source env.sh
```

## Initial setup

Do this only the first time you clone the repository.
If you only want to use Singularity, you can skip the Docker setup (and vice versa).
Docker commands may need to be prepended with `sudo`.

WARNING: the Triton image is 8 GB.

CMSSW:
```bash
cmsrel CMSSW_11_3_0_pre1
cd CMSSW_11_3_0_pre1/src
cmsenv
git cms-addpkg HeterogeneousCore/SonicTriton
cd HeterogeneousCore/SonicTriton
git clone https://github.com/kpedro88/triton_container_example
ln -s triton_container_example bin
scram b
cd triton_container_example
```

Singularity*:
```bash
./pull_singularity.sh
```

Docker:
```bash
./pull_docker.sh
```

Model:
```bash
./get_model.sh
```

\* If you want to use the sandbox from cvmfs instead of building a new one, skip this step and execute the following commands:
```bash
source common.sh
export SANDBOX=/cvmfs/unpacked.cern.ch/registry.hub.docker.com/${IMAGE}
```

## Tests

The argument to the test script specifies how many tests will run.

Singularity:
```bash
./test_singularity.sh 10 >& log_test_singularity.log
```

Docker:
```bash
./test_docker.sh 10 >& log_test_docker.log
```
