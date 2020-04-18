SHELL=/bin/sh

## Colors
ifndef VERBOSE
.SILENT:
endif

IMAGE_PATH=beleneglorion/node
VERSION=latest

## Help
help:
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

## build and push image
all: build push_image

## build image and tags it
build: Dockerfile
	docker build -f Dockerfile . -t ${IMAGE_PATH}:${VERSION}

## login on registry
registry_login:
	docker login
## push image
push_image: registry_login
	docker push ${IMAGE_PATH}:${VERSION}
