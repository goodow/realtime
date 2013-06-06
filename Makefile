# xcrun finds a specified tool in the current SDK /usr/bin directory.
XCRUN = $(shell if test -f /usr/bin/xcrun; then echo xcrun; else echo ""; fi)
MAKE = $(XCRUN) make

include resources/make/common.mk

default: clean translate test

translate: $(GEN_INCLUDE_DIR) elemental operation channel model

elemental:
	@cd gwt/trunk/elemental && $(MAKE) translate

operation:
	@cd realtime-operation && $(MAKE) translate

channel:
	@cd realtime-channel && $(MAKE) translate

model:
	@cd realtime-model && $(MAKE) translate

test:
	@cd gwt/trunk/elemental && $(MAKE) link
	@cd realtime-operation && $(MAKE) test
	@cd realtime-model && $(MAKE) pod_update test

$(GEN_INCLUDE_DIR):
	@mkdir -p $(GEN_INCLUDE_DIR)

clean:
	@rm -rf $(GEN_INCLUDE_DIR)
	@cd gwt/trunk/elemental && $(MAKE) clean
	@cd realtime-operation && $(MAKE) clean
	@cd realtime-channel && $(MAKE) clean
	@cd realtime-model && $(MAKE) clean