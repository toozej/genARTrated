# genARTrated
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

## Gallery
- Uses <https://github.com/soyaine/horcrux> to generate a GitHub Pages-compatible image gallery for displaying generated art
- Uses <https://github.com/madduci/docker-github-pages> to create Dockerized version of gallery for local viewing and iteration
	- Makefile `make gallery-local` grabs the latest Dockerfile from this repo and stores it under `gallery/`
