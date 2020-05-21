SHELL            =   /bin/sh
# .SHELLFLAGS      =   -eo pipefail

docker           :=  docker
docs             :=  $(shell find docs -type f 2>/dev/null)
src              :=  $(shell find src -type f 2>/dev/null)
tests            :=  $(shell find tests -type f 2>/dev/null)

IMAGE_NAME       ?=  app/app
IMAGE_TAG        ?=  latest

.SUFFIXES:
.PHONY: clean \
	print_env \
	test \
	node_modules

all: build

build: build/app build/docs build/coverage

build/docs: $(docs)
	@echo Build docs
	mkdir -p build/docs
	cp -va docs/. build/docs

build/app: $(src)
	@echo Build app
	mkdir -vp build/app
	cp -va src/. build/app

build/coverage: $(tests)
	@echo Build coverage
	mkdir -vp build/coverage
	cp -va tests/. build/coverage

build/image:
	@echo Build docker image
	$(docker) build -t $(IMAGE_NAME):$(IMAGE_TAG) .

node_modules:
	@echo Install dependencies

test:
	@echo Run tests

print_env:
	@echo Print environment
	printenv

clean:
	@echo Clean
	rm -vrf build
