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

Singularity:
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

Client:
```bash
./get_client.sh
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
