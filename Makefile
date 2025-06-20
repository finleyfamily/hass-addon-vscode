CI := $(if $(CI),yes,no)
SHELL := /bin/bash

ifeq ($(CI), yes)
	POETRY_OPTS = "-v"
	PRE_COMMIT_OPTS = --show-diff-on-failure --verbose
endif

fix: run.pre-commit ## run all automatic fixes

fix.md: ## automatically fix markdown format errors
	@poetry run pre-commit run mdformat --all-files

lint: ## run all linters
	@if [ $${CI} ]; then \
		echo ""; \
		echo "skipped linters that have dedicated jobs"; \
	else \
		echo ""; \
		$(MAKE) --no-print-directory lint.docker lint.shellcheck; \
	fi

# for more info: https://github.com/hadolint/hadolint
lint.docker: ## lint Dockerfile
	@echo "Running hadolint..."
	@if [[ $$(command -v hadolint) ]]; then \
		find ./vscode -name "*Dockerfile*" -type f | \
			xargs hadolint; \
	else \
		echo "hadolint not installed - install it to lint Dockerfiles"; \
		echo "  - macOS: brew install hadolint"; \
	fi
	@echo ""

lint.shellcheck: ## lint shell scripts using shellcheck
	@echo "Running shellcheck..." && \
	bash ./tests/shellcheck.sh && \
	echo ""

permissions: ## set script permissions
	@find ./vscode/rootfs/etc/s6-overlay/s6-rc.d -type f \( -name run -or -name finish \) -prune -exec chmod +x {} \;
	@find ./vscode/rootfs/usr/local/bin -type f -prune -exec chmod +x {} \;

run.pre-commit: ## run pre-commit for all files
	@poetry run pre-commit run $(PRE_COMMIT_OPTS) \
		--all-files \
		--color always

settings.hash: ## generate hash of settings file to apply updates to default settings
	@sha512sum vscode/rootfs/root/.code-server/settings.json | cut -d " " -f 1
	@echo "add the above value to PREVIOUS_DEFAULT_CONFIG_HASHES in vscode/rootfs/etc/s6-overlay/s6-rc.d/init-code-server/run"

setup: setup.poetry setup.pre-commit setup.npm ## setup dev environment

setup.npm: ## install node dependencies with npm
	@npm ci

setup.poetry: ## setup python virtual environment
	@poetry check
	@poetry sync $(POETRY_OPTS)

setup.pre-commit: ## install pre-commit git hooks
	@poetry run pre-commit install

spellcheck: ## run cspell
	@echo "Running cSpell to checking spelling..."
	@npm exec --no -- cspell lint . \
		--color \
		--config .vscode/cspell.json \
		--dot \
		--gitignore \
		--must-find-files \
		--no-progress \
		--relative \
		--show-context

test: ## run tests
	@echo "no tests configured for this project"
