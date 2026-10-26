# @(#)quiet-terminology / make / Makefile / 2026-10-26

PYTHON ?= python3
EET ?= eet
QUIET ?= ../quiet

TOOL := $(PYTHON) tools/quiet_terminology.py

CONFIG_HOME ?= $(if $(XDG_CONFIG_HOME),$(XDG_CONFIG_HOME),$(HOME)/.config)
DEST ?= $(CONFIG_HOME)/terminology/colorschemes

DAY := colorschemes/quiet-day.eet
NIGHT := colorschemes/quiet-night.eet

.DEFAULT_GOAL := check

# Verifies generated artifacts and contrast. The .eet files are also
# rebuilt and compared when EFL's eet tool is available.
.PHONY: check
check:
	@$(TOOL) check $$(command -v $(EET) || true)

.PHONY: vendor
vendor:
	$(TOOL) vendor $(QUIET)

.PHONY: generate
generate:
	$(TOOL) generate

.PHONY: build
build: generate
	$(TOOL) build $$(command -v $(EET))

.PHONY: install
install:
	mkdir -p "$(DEST)"
	cp "$(DAY)" "$(NIGHT)" "$(DEST)/"

# Also removes the schemes' names before quiet 0.5.0.
.PHONY: uninstall
uninstall:
	rm -f "$(DEST)/quiet-day.eet" "$(DEST)/quiet-night.eet"
	rm -f "$(DEST)/Quiet Day.eet" "$(DEST)/Quiet Night.eet"
