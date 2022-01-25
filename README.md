# genARTrated
[![GitHub Container Registry](https://img.shields.io/static/v1.svg?&style=for-the-badge&label=toozej&message=GitHub%20Container%20Registry&logo=github)](https://github.com/users/toozej/packages/container/package/genartrated)
[![Quay.io](https://img.shields.io/static/v1.svg?style=for-the-badge&label=toozej&message=Quay.io)](https://quay.io/repository/toozej/genartrated)
[![Docker Pulls](https://img.shields.io/docker/pulls/toozej/genartrated.svg?style=for-the-badge&label=DockerHub&logo=docker)](https://hub.docker.com/r/toozej/genartrated)

A home for generated art

Run all projects with `make all`

## General Pre-reqs
- Docker
- GNU Make

## Samila
Art in this directory is generated using <https://github.com/sepandhaghighi/samila>

### Manual
Execute `samila/main.py` to generate art manually (without using Docker) using the various Samila options

### Docker
Note the following build and run commands are executed "automatically" as part of `make build` and `make run` respectively

- Build: `docker build -t toozej/genartrated:samila .`
- Run: `docker run --rm -v $(pwd)/samila/out:/out toozej/genartrated:samila`
- Interactive: `docker run --rm -it --entrypoint=python -v $(pwd)/samila/out:/out toozej/genartrated:samila`
