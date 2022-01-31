.PHONY: all build run project-build project-run project copy gallery-compile gallery-view gallery load clean $(PROJECTS)

# All projects have a Dockerfile, so create a list of project dirs based on dirs containing a Dockerfile
# idea from https://philpep.org/blog/a-makefile-for-your-dockerfiles/
DOCKERFILES = $(shell find * -type f -name Dockerfile)
PROJECTS = $(subst /Dockerfile,,$(DOCKERFILES)) 

# Steps make extensive use of strip function to remove trailing whitespace on variables in $(PROJECTS) list
# See https://unix.stackexchange.com/a/271818

# If the first argument is "project"...
ifeq (project,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "project"
  PROJECT_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(PROJECT_ARGS):;@:)
endif
# Idea from https://stackoverflow.com/a/14061796


all: $(PROJECTS) build run copy gallery

build:
	docker build -f $(CURDIR)/$(strip $(PROJECTS))/Dockerfile -t toozej/genartrated:$(strip $(PROJECTS)) $(strip $(PROJECTS))/ 

run: 
	docker run --rm --name $(strip $(PROJECTS)) -v $(CURDIR)/$(strip $(PROJECTS))/out:/out toozej/genartrated:$(strip $(PROJECTS))

project-build:
	docker build -f $(CURDIR)/$(strip $(PROJECT_ARGS))/Dockerfile -t toozej/genartrated:$(strip $(PROJECT_ARGS)) $(strip $(PROJECT_ARGS))/

project-run:
	docker run --rm --name $(strip $(PROJECT_ARGS)) -v $(CURDIR)/$(strip $(PROJECT_ARGS))/out:/out toozej/genartrated:$(strip $(PROJECT_ARGS))

project: project-build project-run

copy:
	cp -r $(CURDIR)/$(strip $(PROJECTS))/out/* $(CURDIR)/gallery/photos/$(strip $(PROJECTS))/

gallery-compile:
	docker build -f $(CURDIR)/docs/Dockerfile-compile -t toozej/genartrated:gallery-compile docs/
	docker run --rm --name gallery-compile -v $(CURDIR)/docs:/app toozej/genartrated:gallery-compile

gallery-view:
	docker build -f $(CURDIR)/docs/Dockerfile-view -t toozej/genartrated:gallery-view docs/
	docker run --rm --name gallery-view -v $(CURDIR)/docs:/site -p 8080:4000 toozej/genartrated:gallery-view serve --watch --force_polling --host 0.0.0.0

gallery: gallery-compile gallery-view

load: $(PROJECTS) copy gallery

clean: 
	rm -f $(CURDIR)/$(strip $(PROJECTS))/out/*
