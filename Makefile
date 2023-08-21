.PHONY: help test install dialyzer credo all

help:
	@echo "test - run tests"
	@echo "install - install dependencies"
	@echo "dialyzer - run dialyzer"
	@echo "credo - run credo"
	@echo "all - run all"

test:
	mix test

install:
	mix deps.get

dialyzer:
	mix dialyzer

credo:
	mix credo --strict

all:
	make install
	make test
	make dialyzer
	make credo
