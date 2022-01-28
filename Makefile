.PHONY: all build run clean $(PROJECTS)

# All projects have a Dockerfile, so create a list of project dirs based on dirs containing a Dockerfile
# idea from https://philpep.org/blog/a-makefile-for-your-dockerfiles/
DOCKERFILES = $(shell find * -type f -name Dockerfile)
PROJECTS = $(subst /Dockerfile,,$(DOCKERFILES)) 

# Steps make extensive use of strip function to remove trailing whitespace on variables in $(PROJECTS) list
# See https://unix.stackexchange.com/a/271818

all: $(PROJECTS) build run copy gallery

build:
	docker build -f $(CURDIR)/$(strip $(PROJECTS))/Dockerfile -t toozej/genartrated:$(strip $(PROJECTS)) $(strip $(PROJECTS))/ 

run: 
	docker run --rm -v $(CURDIR)/$(strip $(PROJECTS))/out:/out toozej/genartrated:$(strip $(PROJECTS))

copy:
	cp -r $(CURDIR)/$(strip $(PROJECTS))/out/* $(CURDIR)/gallery/photos/$(strip $(PROJECTS))/

gallery-compile:
	docker build -f $(CURDIR)/gallery/Dockerfile-compile -t toozej/genartrated:gallery-compile gallery/
	docker run --rm -v $(CURDIR)/gallery:/gallery toozej/genartrated:gallery-compile

gallery-view:
	curl -s https://raw.githubusercontent.com/madduci/docker-github-pages/master/Dockerfile > gallery/Dockerfile-view
	docker build -f $(CURDIR)/gallery/Dockerfile-view -t toozej/genartrated:gallery-view gallery/
	docker run --rm -v $(CURDIR)/gallery:/site -p 8080:4000 toozej/genartrated:gallery-view install && exec jekyll serve --watch --force_polling --host 0.0.0.0

gallery: $(PROJECTS) gallery-compile gallery-view

load: $(PROJECTS) copy gallery

clean: 
	rm -f $(CURDIR)/$(strip $(PROJECTS))/out/*
