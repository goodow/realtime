# Common variables for the various subprojects of j2objc.

J2OBJC_DIST = $(HOME)/dev/tools/lib/j2objc/dist
M2_REPO = $(HOME)/.m2/repository

ROOT_DIR = $(dir $(lastword $(MAKEFILE_LIST)))../..
MAIN_SRC_DIR = $(CURDIR)/src/main/java
MAIN_SOURCE_LIST = $(BUILD_DIR)/main.sources.list
TEST_SOURCE_LIST = $(BUILD_DIR)/test.sources.list
GEN_INCLUDE_DIR = $(GDREALTIME_DIR)/Classes/generated/include

GDREALTIME_DIR = $(ROOT_DIR)/GDRealtime
ELEMENTAL_DIR = $(ROOT_DIR)/gwt/trunk/elemental
ELEMENTAL_GEN_DIR = $(GDREALTIME_DIR)/Classes/generated/elemental
OPERATION_GEN_DIR = $(GDREALTIME_DIR)/Classes/generated/operation
CHANNEL_GEN_DIR = $(GDREALTIME_DIR)/Classes/generated/channel
API_GEN_DIR = $(GDREALTIME_DIR)/Classes/generated/api
API_DIR = $(ROOT_DIR)/realtime-api

TEST_SRC_DIR = $(CURDIR)/src/test/java
TEST_BIN = $(BUILD_DIR)/jre_unit_tests
JUNIT_JAR = $(J2OBJC_DIST)/lib/junit-4.10.jar
TEST_GEN_DIR = $(GDREALTIME_DIR)/Classes/test_generated

OCNI_SRC_DIR = $(CURDIR)/src/main/objectivec

J2OBJC = $(J2OBJC_DIST)/j2objc -use-arc \
  --prefixes $(ROOT_DIR)/resources/j2objc/package-prefixes.properties \
  --mapping $(ROOT_DIR)/resources/j2objc/method-mappings.properties
  
ifdef CONFIGURATION_BUILD_DIR
# In Xcode build
BUILD_DIR = $(CONFIGURATION_BUILD_DIR)/build
ARCHFLAGS = $(ARCHS:%=-arch %)
SDKFLAGS = -isysroot $(SDKROOT)
else
# In command-line build
# BUILD_DIR = $(HOME)/build
BUILD_DIR = $(CURDIR)/target/j2objc
ARCHFLAGS =
SDKFLAGS =
endif

ifdef OPTIMIZATION_LEVEL
DEBUGFLAGS := $(DEBUGFLAGS) -O$(OPTIMIZATION_LEVEL)
endif

ifdef OTHER_CFLAGS
DEBUGFLAGS := $(DEBUGFLAGS) $(OTHER_CFLAGS)
endif

# Workaround for iPhoneSimulator SDK's gcc bug
ifdef EFFECTIVE_PLATFORM_NAME
ifneq ($(EFFECTIVE_PLATFORM_NAME), -iphonesimulator)
WARNINGS := $(WARNINGS) -Wreturn-type
endif
endif

J2OBJCC_FLAGS = -ObjC $(WARNINGS) $(SDKFLAGS) $(ARCHFLAGS) $(DEBUGFLAGS)
J2OBJCC = $(J2OBJC_DIST)/j2objcc $(J2OBJCC_FLAGS)
