TARGET := iphone:clang:16.5:14.0
INSTALL_TARGET_PROCESSES = CapCut

ARCHS = arm64 arm64e

TWEAK_NAME = CapCutVIP
CapCutVIP_FILES = Tweak.xm
CapCutVIP_CFLAGS = -fobjc-arc
CapCutVIP_FRAMEWORKS = UIKit Foundation
CapCutVIP_LIBRARIES = substrate

include $(THEOS)/makefiles/common.mk
include $(THEOS)/makefiles/tweak.mk
