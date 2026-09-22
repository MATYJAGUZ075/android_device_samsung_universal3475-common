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

# Spec SELinux para /cpefs por vía file_contexts.modules.tmp, independiente
# de file_contexts.device.tmp: usa el type de plataforma system_file (válido
# en la policy de sistema que valida checkfc), no el type vendor sec_efs_file.
# En runtime /cpefs queda tapado por el mount de la partición CPEFS (fstab).
LOCAL_FILE_CONTEXTS += $(LOCAL_PATH)/../sepolicy/vendor/file_contexts_cpefs

include $(BUILD_SHARED_LIBRARY)
