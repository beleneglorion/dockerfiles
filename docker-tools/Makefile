SHELL=/bin/sh

## Colors
ifndef VERBOSE
.SILENT:
endif
COLOR_COMMENT=\033[0;32m
COLOR_INFO=\033[0;33m
COLOR_RESET=\033[0m

IMAGE_PATH=beleneglorion/docker-tools
VERSION=latest
IMAGE=${IMAGE_PATH}:${VERSION}

## Help
help:
	printf "\n"
	printf "${COLOR_COMMENT}Usage:${COLOR_RESET}\n"
	printf " make [target]\n\n"
	printf "${COLOR_COMMENT}Available targets:${COLOR_RESET}\n"
	awk '/^[a-zA-Z\-\_0-9\.@]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf " ${COLOR_INFO}%-16s${COLOR_RESET} %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)
	printf "\n"

## build and push image
all: build push_image

## build image and tags it
build: Dockerfile
	docker build -f Dockerfile . -t ${IMAGE}

## push image
push_image:
	docker push ${IMAGE}

