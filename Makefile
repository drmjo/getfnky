PACKAGE_NAME:=github.com/anthoneous/getfnky
DEFAULT_TARGET:=all

define env
docker run --rm \
	-v `pwd`/tmp:/go/ \
	-v `pwd`:/go/src/$(PACKAGE_NAME) \
	golang:1.10-stretch
endef

.PHONY: all
all: build test

# install
.PHONY: build
build:
	$(env) go get -v $(PACKAGE_NAME)

.PHONY: test
test:
	$(env) getfnky
	$(env) getfnky get
	$(env) getfnky search
