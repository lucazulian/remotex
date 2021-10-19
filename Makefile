##
# Make utility to automate boring and repetitive commands
#
# @file Makefile
# @version 0.1

all: init
.PHONY: init start up build shell delete

init: up setup compile

start: up setup compile				## Start application
	docker-compose exec remotex mix phx.server

up:									## Start all services
	docker-compose up -d --remove-orphans

build:								## Build all services containers
	docker-compose build

shell: container-remotex			## Enter into remotex service
	docker-compose exec remotex bash

halt:								## Shoutdown all services containers
	docker-compose down

delete: halt						## Delete all containers, images and volumes
	@docker images -a | grep "remotex" | awk '{print $3}' | xargs docker rmi -f | docker ps -a | grep "remotex" | awk '{print $1}' | xargs docker rm -v

help:
	@echo "Usage: make [command]"
	@echo "Make utility to automate boring and repetitive commands."
	@echo
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo

container-%:
	@docker ps -q --no-trunc --filter status=running | grep $$(docker-compose ps -q $*) >/dev/null 2>&1 || docker-compose up -d $*

# end
