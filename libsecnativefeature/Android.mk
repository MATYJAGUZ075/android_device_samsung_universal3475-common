LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := \
	SecNativeFeatureCIf.cpp \
	SecNativeFeatureCppIf.cpp

LOCAL_C_INCLUDES += \
	external/expat/lib

LOCAL_SHARED_LIBRARIES := \
	libexpat

LOCAL_CFLAGS := -Wall -Werror

LOCAL_MODULE := libsecnativefeature

# Specs SELinux vendor (incl. /cpefs) por vía file_contexts.modules.tmp,
# independiente de file_contexts.device.tmp: si device.tmp los trae, el
# duplicado idéntico es legal (first-match); si viene vacío, esta vía los
# aporta y e2fsdroid puede etiquetar /cpefs en system.img.
LOCAL_FILE_CONTEXTS += $(LOCAL_PATH)/../sepolicy/vendor/file_contexts

include $(BUILD_SHARED_LIBRARY)
