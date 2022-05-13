SHELL := /bin/bash
PYTHON_ENV := . .venv/bin/activate
PYTHON := ${PYTHON_ENV} && python
REGISTRY = quay.io
REPOSITORY = aptible/deploy-demo-app

init:
	docker-compose build --no-cache

start:
	docker-compose up

test: build
	set -e ; if [ -f 'test.sh' ]; then ./test.sh; break; fi

build:
	docker build -t "$(REGISTRY)/$(REPOSITORY)" -f Dockerfile .

install: .venv
	$(PYTHON) -m pip install -e .[dev]

.venv:
	python -m venv .venv

.PHONY: test build install .venv
.DEFAULT_GOAL := test
