# xcrun finds a specified tool in the current SDK /usr/bin directory.
XCRUN = $(shell if test -f /usr/bin/xcrun; then echo xcrun; else echo ""; fi)
MAKE = $(XCRUN) make

include resources/make/common.mk

default: clean translate test

translate: $(GEN_INCLUDE_DIR) operation channel store

operation:
	@cd realtime-operation && $(MAKE) translate

channel:
	@cd realtime-channel && $(MAKE) translate

store:
	@cd realtime-store && $(MAKE) translate

test:
	@cd realtime-operation && $(MAKE) test
	@cd realtime-store && $(MAKE) pod_update test

$(GEN_INCLUDE_DIR):
	@mkdir -p $(GEN_INCLUDE_DIR)

clean:
	@rm -rf $(GEN_INCLUDE_DIR)
	@cd realtime-operation && $(MAKE) clean
	@cd realtime-channel && $(MAKE) clean
	@cd realtime-store && $(MAKE) clean