DOCKER := $(shell which docker)
DOCKER_COMPOSE := $(DOCKER) compose

.PHONY: dc-build
dc-build: ## Build all images
	$(DOCKER_COMPOSE) stop
	$(DOCKER_COMPOSE) build
	$(DOCKER_COMPOSE) up -d

.DEFAULT_GOAL := dc-build

.PHONY: bash-interactive
bash-interactive: ## Bash interactive
	$(DOCKER_COMPOSE) run -it --rm android-sdk-emulator-interactive bash

.PHONY: bash-interactive-network-host
bash-interactive-network-host: ## Bash interactive with adb accessible on host
	$(DOCKER_COMPOSE) run -it --rm android-sdk-emulator-interactive-network-on-host bash

.PHONY: bash
bash: ##  Bash none interactive
	$(DOCKER_COMPOSE) run -it --rm android-sdk-emulator bash

.PHONY: packages
packages: ## check installed packages
	$(DOCKER_COMPOSE) run -it --rm android-sdk-emulator sdkmanager --list

.PHONY: ls-emul
ls-emul: ## list existing emulators
	$(DOCKER_COMPOSE) run -it --rm android-sdk-emulator avdmanager list avd