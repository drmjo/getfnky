# lambda build
DEFAULT_TARGET:=build
.PHONY: build
build:
	docker run -it --rm \
		-w /data \
		-v `pwd`:/data \
		drmjo/terraform:0.11.7 zip build/pkg.zip main.js
