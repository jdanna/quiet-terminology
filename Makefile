# @(#)quiet-terminology / make / Makefile / 2026-10-23

PYTHON ?= python3
EET ?= eet
QUIET ?= ../quiet

TOOL := $(PYTHON) tools/quiet_terminology.py

CONFIG_HOME ?= $(if $(XDG_CONFIG_HOME),$(XDG_CONFIG_HOME),$(HOME)/.config)
DEST ?= $(CONFIG_HOME)/terminology/colorschemes

DAY := colorschemes/Quiet Day.eet
NIGHT := colorschemes/Quiet Night.eet

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

.PHONY: uninstall
uninstall:
	rm -f "$(DEST)/Quiet Day.eet" "$(DEST)/Quiet Night.eet"
