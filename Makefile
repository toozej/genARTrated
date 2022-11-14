# Set sane defaults for Make
SHELL = bash
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

# Set default goal such that `make` runs `make help`
.DEFAULT_GOAL := help

# Assuming each subdirectory `foobar` containing a Dockerfile
# is where we `docker build` the image `foobar` 
PROJECTS  := $(patsubst %/,%,$(dir $(wildcard */Dockerfile)))
# can also override PROJECTS list with argument to make command like:
# `make all PROJECTS=fractals` to just run "all" target with only fractals project

MARKDOWNS := $(shell find * -type f -name "README.md")

init_%:
	@echo -e "\nInitializing $*"
	mkdir $(CURDIR)/$*/out
	chmod 0777 $(CURDIR)/$*/out

build_%:
	@echo -e "\nBuilding $*"
	docker build -f $(CURDIR)/$*/Dockerfile -t toozej/genartrated:$* $(CURDIR)/$*

run_%:
	@echo -e "\nRunning $*"
	docker run --rm --name $* -v $(CURDIR)/$*/out:/out toozej/genartrated:$*

copy_%:
	@echo -e "\nCopying $*"
	mkdir -p $(CURDIR)/docs/photos/$*
	cp -r $(CURDIR)/$*/out/* $(CURDIR)/docs/photos/$*/
	chmod -R ugo+rw $(CURDIR)/docs/photos/$*/

clean_%:
	@echo -e "\nCleaning $*"
	rm -f $(CURDIR)/$*/out/*
	docker image rm toozej/genartrated:$*

.PHONY: all init build run copy gallery-compile gallery-view gallery load generate-toc-build generate-toc-run generate-toc pre-commit pre-commit-install pre-commit-run clean help

all: build run copy gallery ## Run default workflow

init: clean $(addprefix init_,$(PROJECTS)) ## Clean and initalize project structure

build: $(addprefix build_,$(PROJECTS)) ## Build Dockerized projects

run: $(addprefix run_,$(PROJECTS)) ## Run Dockerized projects

copy: $(addprefix copy_,$(PROJECTS)) ## Copy output from Dockerized projects to gallery input dirs

gallery-compile: ## Compile web gallery
	docker build -f $(CURDIR)/docs/Dockerfile-compile -t toozej/genartrated:gallery-compile docs/
	docker run --rm --name gallery-compile -v $(CURDIR)/docs:/app toozej/genartrated:gallery-compile

gallery-view: ## Display web gallery
	docker build -f $(CURDIR)/docs/Dockerfile-view -t toozej/genartrated:gallery-view docs/
	docker run --rm --name gallery-view -v $(CURDIR)/docs:/site -p 8080:4000 toozej/genartrated:gallery-view serve --watch --force_polling --host 0.0.0.0

gallery: gallery-compile gallery-view ## Compile and display web gallery

load: copy gallery ## Load up output images to web gallery, then compile and display gallery

generate-toc-build: ## Build table-of-contents generator tool
	docker build -f $(CURDIR)/tools/Dockerfile-tocgen -t toozej/tocgen:latest tools/

generate-toc-run: ## Generate table-of-contents for README.md files
	for md in $(MARKDOWNS); do \
		echo -e "Generating markdown table-of-contents for $${md}\n"; \
		docker run --rm --name tocgen -v $(CURDIR):/data --user $(shell id -u):$(shell id -g) toozej/tocgen:latest /data/$${md}; \
	done

generate-toc: generate-toc-build generate-toc-run ## Build and generate table-of-contents

pre-commit: pre-commit-install pre-commit-run ## Install and run pre-commit hooks

pre-commit-install: ## Install pre-commit hooks and necessary binaries
	# install and update pre-commits
	pre-commit install
	pre-commit autoupdate

pre-commit-run: ## Run pre-commit hooks against all files
	pre-commit run --all-files

clean: $(addprefix clean_,$(PROJECTS)) ## Clean up generated images and built Docker images

help: ## Display help text
	@grep -E '^[a-zA-Z_-]+ ?:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
