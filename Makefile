.PHONY: help test install dialyzer credo format docker_rabbitmq start

help:
	@echo "test - run tests"
	@echo "install - install dependencies"
	@echo "dialyzer - run dialyzer"
	@echo "credo - run credo"
	@echo "format - run formatter"
	@echo "docker_rabbitmq - run rabbitmq in docker"
	@echo "start - run application"

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

docker_rabbitmq:
	docker-compose up --build -d rabbitmq

start:
	mix run --no-halt

