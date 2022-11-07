# Assuming each subdirectory `foobar` containing a Dockerfile
# is where we `docker build` the image `foobar` 
PROJECTS  := $(patsubst %/,%,$(dir $(wildcard */Dockerfile)))

# use the rest as arguments for "project"
define fetch_parameter
    $(eval target_name:= $(firstword $(MAKECMDGOALS)))
    $(eval varname := $(target_name)_value)
    $(eval $(varname) := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS)))
    $(eval $($(varname))::;@:)
endef


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

.PHONY: all init build run copy project gallery-compile gallery-view gallery load clean $(PROJECTS)

all: build run copy gallery

init: clean $(addprefix init_,$(PROJECTS))

build: $(addprefix build_,$(PROJECTS))

run: $(addprefix run_,$(PROJECTS))

copy: $(addprefix copy_,$(PROJECTS))

project: res := $(call fetch_parameter)
project:
	@echo -e "\nWorking on project $($@_value)"
	$(addprefix build_,$($@_value))
	$(addprefix run_, $($@_value))
	$(addprefix copy_,$($@_value))

gallery-compile:
	docker build -f $(CURDIR)/docs/Dockerfile-compile -t toozej/genartrated:gallery-compile docs/
	docker run --rm --name gallery-compile -v $(CURDIR)/docs:/app toozej/genartrated:gallery-compile

gallery-view:
	docker build -f $(CURDIR)/docs/Dockerfile-view -t toozej/genartrated:gallery-view docs/
	docker run --rm --name gallery-view -v $(CURDIR)/docs:/site -p 8080:4000 toozej/genartrated:gallery-view serve --watch --force_polling --host 0.0.0.0

gallery: gallery-compile gallery-view

load: copy gallery

clean: $(addprefix clean_,$(PROJECTS))
