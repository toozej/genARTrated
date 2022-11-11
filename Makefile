# Assuming each subdirectory `foobar` containing a Dockerfile
# is where we `docker build` the image `foobar` 
PROJECTS  := $(patsubst %/,%,$(dir $(wildcard */Dockerfile)))

# can also override PROJECTS list with argument to make command like:
# `make all PROJECTS=fractals` to just run "all" target with only fractals project

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

.PHONY: all init build run copy gallery-compile gallery-view gallery load clean

all: build run copy gallery

init: clean $(addprefix init_,$(PROJECTS))

build: $(addprefix build_,$(PROJECTS))

run: $(addprefix run_,$(PROJECTS))

copy: $(addprefix copy_,$(PROJECTS))

gallery-compile:
	docker build -f $(CURDIR)/docs/Dockerfile-compile -t toozej/genartrated:gallery-compile docs/
	docker run --rm --name gallery-compile -v $(CURDIR)/docs:/app toozej/genartrated:gallery-compile

gallery-view:
	docker build -f $(CURDIR)/docs/Dockerfile-view -t toozej/genartrated:gallery-view docs/
	docker run --rm --name gallery-view -v $(CURDIR)/docs:/site -p 8080:4000 toozej/genartrated:gallery-view serve --watch --force_polling --host 0.0.0.0

gallery: gallery-compile gallery-view

load: copy gallery

clean: $(addprefix clean_,$(PROJECTS))
