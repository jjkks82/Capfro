TARGET := iphone:clang:latest:7.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CapCutNoProtection

CapCutNoProtection_FILES = Tweak.xm
CapCutNoProtection_CFLAGS = -fobjc-arc
CapCutNoProtection_FRAMEWORKS = UIKit Foundation

include $(THEOS_MAKE_PATH)/tweak.mk
