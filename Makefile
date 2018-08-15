DEFAULT_TARGET:=all

package:=github.com/anthoneous/getfnky
image:=anthoneous/getfnky
tag:=latest

define env
docker run --rm \
	-v `pwd`/tmp:/go/ \
	-v `pwd`:/go/src/$(package) \
	golang:1.10-stretch
endef

.PHONY: all
all: build test docker-build

# install
.PHONY: build
build:
	$(env) go get -v $(package)

.PHONY: test
test:
	$(env) getfnky
	$(env) getfnky get
	$(env) getfnky search

.PHONY: docker-build
docker-build:
	docker build \
		--build-arg PACKAGE=$(package) \
		-t $(image):$(tag) \
	  .

.PHONY: docker-push
docker-push:
	docker push $(image):$(tag)
