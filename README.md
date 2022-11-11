<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [genARTrated](#genartrated)
  - [General Pre-reqs](#general-pre-reqs)
  - [Execution](#execution)
    - [Make](#make)
    - [Docker](#docker)
    - [Manual](#manual)
  - [Projects](#projects)
    - [Samila](#samila)
    - [Fractals](#fractals)
  - [Gallery](#gallery)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# genARTrated
A home for generated art

Run all projects with `make all`

## General Pre-reqs
- Docker
- GNU Make

## Execution
### Make
- Make all projects: `make all`
- Make a specific project $proj: `make all PROJECTS=$proj`
- Make the web gallery: `make gallery`

### Docker
Note the following build and run commands are executed "automatically" as part of `make build` and `make run` respectively

For a specific project $proj:
- Build: `docker build -t toozej/genartrated:$proj .`
- Run: `docker run --rm -v $(pwd)/$proj/out:/out toozej/genartrated:$proj`
- Interactive:
	- for Python-based projects: `docker run --rm -it --entrypoint=python -v $(pwd)/$proj/out:/out toozej/genartrated:$proj`

### Manual
For Python-based projects, execute `$proj/main.py` to generate art manually (without using Docker). Be sure to create a virtualenv
and install the necessary requirements before running!

## Projects
### Samila
Art in this directory is generated using <https://github.com/sepandhaghighi/samila>
- See [the Samila README](./samila/README.md) for more information

### Fractals
Art in this directory is generated using <https://github.com/anovik/fractals>. 
- See [the fractals README](./fractals/README.md) for more information

## Gallery
- Stored in genARTrated repo as `docs/` since GitHub Pages will only publish from root or `docs/` directories :(
- Uses <https://github.com/soyaine/horcrux> to generate a GitHub Pages-compatible image gallery for displaying generated art
- Uses <https://github.com/madduci/docker-github-pages> to create Dockerized version of gallery for local viewing and iteration
- See [the gallery README](./docs/README.md) for more information
