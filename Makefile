.PHONY: help test install dialyzer credo format docker all

help:
	@echo "test - run tests"
	@echo "install - install dependencies"
	@echo "dialyzer - run dialyzer"
	@echo "credo - run credo"
	@echo "format - run formatter"
	@echo "docker - run docker"
	@echo "all - run all"

test:
	mix test

install:
	mix deps.get

dialyzer:
	mix dialyzer

credo:
	mix credo --strict

format:
	mix format

docker:
	docker-compose up --build -d

all:
	make install
	make test
	make dialyzer
	make credo
	make format
