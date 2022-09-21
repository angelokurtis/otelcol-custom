.PHONY: help
help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

.PHONY: build
build: ## Build the docker image
	docker build -t kurtis/otel-collector:v1.0.8 .

.PHONY: publish
publish: ## Push docker image
	docker push kurtis/otel-collector:v1.0.8
