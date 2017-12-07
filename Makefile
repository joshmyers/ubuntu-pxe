
vagrant:
	@vagrant up
	@vagrant ssh -c "sudo bash /vagrant/scripts/configure-pxe-server.sh"
	@echo "=====> Completed pxe vagrant server"
	@vagrant ssh -c "sudo bash /vagrant/scripts/create-iso.sh"

clean:
	vagrant destroy -f

.DEFAULT_GOAL := help
SHELL := /bin/bash

.PHONY: help
help:
	@cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: build
build: ## build the PXE server docker image
	@echo "==> Building HMPO PXE server container"
	@docker pull `grep "FROM " Dockerfile | cut -d ' ' -f 2` || true
	@docker build \
	  -t joshmyers/pxe-docker \
	  .

.PHONY: create_iso
create-iso: build ## Create ISO - output to $PWD
	docker run -it --rm \
	  --net host \
	  -v ${PWD}:/pxe \
	  joshmyers/pxe-docker \
	  --privileged \
	  create-iso.sh
