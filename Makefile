SHELL            =   /bin/sh
docs             :=  $(shell find docs -type f)
src              :=  $(shell find src -type f)
tests            :=  $(shell find tests -type f)

.SUFFIXES:
.PHONY: clean

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

clean:
	@echo Clean
	rm -vrf build
