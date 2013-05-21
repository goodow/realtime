# xcrun finds a specified tool in the current SDK /usr/bin directory.
XCRUN = $(shell if test -f /usr/bin/xcrun; then echo xcrun; else echo ""; fi)
MAKE = $(XCRUN) make


GDREALTIME_DIR = GDRealtime
GEN_INCLUDE_DIR = $(GDREALTIME_DIR)/Classes/generated/include

default: clean translate

translate: $(GEN_INCLUDE_DIR) elemental model channel

elemental:
	@cd gwt/trunk/elemental && $(MAKE) translate

model:
	@cd realtime-model && $(MAKE) translate pod_update test

channel:
	@cd realtime-channel && $(MAKE) translate pod_update

$(GEN_INCLUDE_DIR):
	@mkdir -p $(GEN_INCLUDE_DIR)

clean:
	@rm -rf $(GEN_INCLUDE_DIR)
	@cd gwt/trunk/elemental && $(MAKE) clean
	@cd realtime-model && $(MAKE) clean
	@cd realtime-channel && $(MAKE) clean
	