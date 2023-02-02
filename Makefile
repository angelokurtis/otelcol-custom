VERSION ?= 1.0.9
IMAGE_TAG_BASE ?= kurtis/otel-collector
IMG ?= $(IMAGE_TAG_BASE):$(VERSION)

.PHONY: help
help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

.PHONY: build
build: ## Build the docker image.
	docker build -t $(IMG) .

.PHONY: publish
publish: ## Push docker image.
	docker push $(IMG)
