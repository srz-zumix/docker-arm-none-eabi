DOCKER_TAG?=10-2020q4
IMAGE_NAME:=srzzumix/arm-none-eabi:${DOCKER_TAG}
DOCKERFILE_PATH:=./Dockerfile

help: ## Display this help screen
	@grep -E '^[a-zA-Z][a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sed -e 's/^GNUmakefile://' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

build: ## build image
	DOCKER_TAG=${DOCKER_TAG} IMAGE_NAME=${IMAGE_NAME} DOCKERFILE_PATH=${DOCKERFILE_PATH} ./hooks/build

run: ## run image
	docker run -it --rm ${IMAGE_NAME} bash 

version: ## show gcc version
	DOCKER_TAG=${DOCKER_TAG} IMAGE_NAME=${IMAGE_NAME} DOCKERFILE_PATH=${DOCKERFILE_PATH} ./hooks/post_push

6:
	DOCKER_TAG="6-2016q4" make -C . build
6-run:
	DOCKER_TAG="6-2016q4" make -C . run

9:
	DOCKER_TAG="9-2019q4" make -C . build
9-run:
	DOCKER_TAG="9-2019q4" make -C . run
