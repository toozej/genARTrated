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
