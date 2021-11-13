.PHONY: all build run clean $(PROJECTS)

# All projects have a Dockerfile, so create a list of project dirs based on dirs containing a Dockerfile
# idea from https://philpep.org/blog/a-makefile-for-your-dockerfiles/
DOCKERFILES = $(shell find * -type f -name Dockerfile)
PROJECTS = $(subst /Dockerfile,,$(DOCKERFILES)) 

# Steps make extensive use of strip function to remove trailing whitespace on variables in $(PROJECTS) list
# See https://unix.stackexchange.com/a/271818

all: $(PROJECTS) build run

build:
	docker build -f $(CURDIR)/$(strip $(PROJECTS))/Dockerfile -t toozej/genartrated:$(strip $(PROJECTS)) $(strip $(PROJECTS))/ 

run: 
	docker run --rm -v $(CURDIR)/$(strip $(PROJECTS))/out:/out toozej/genartrated:$(strip $(PROJECTS))

clean: 
	rm -f $(CURDIR)/$(strip $(PROJECTS))/out/*
