.PHONY: help test install dialyzer credo format all

help:
	@echo "test - run tests"
	@echo "install - install dependencies"
	@echo "dialyzer - run dialyzer"
	@echo "credo - run credo"
	@echo "format - run formatter"
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

all:
	make install
	make test
	make dialyzer
	make credo
	make format
