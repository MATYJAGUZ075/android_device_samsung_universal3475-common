LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE		:= fstab.universal3475
LOCAL_MODULE_TAGS	:= optional
LOCAL_MODULE_CLASS	:= ETC
LOCAL_SRC_FILES		:= etc/fstab.universal3475
LOCAL_MODULE_PATH	:= $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

# Init scripts

include $(CLEAR_VARS)
LOCAL_MODULE            := init.baseband.rc
LOCAL_MODULE_TAGS       := optional
LOCAL_MODULE_CLASS      := ETC
LOCAL_SRC_FILES         := etc/init.baseband.rc
LOCAL_MODULE_PATH       := $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE            := init.power.rc
LOCAL_MODULE_TAGS       := optional
LOCAL_MODULE_CLASS      := ETC
LOCAL_SRC_FILES         := etc/init.power.rc
LOCAL_MODULE_PATH       := $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE            := init.wifi.rc
LOCAL_MODULE_TAGS       := optional
LOCAL_MODULE_CLASS      := ETC
LOCAL_SRC_FILES         := etc/init.wifi.rc
LOCAL_MODULE_PATH       := $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE		:= init.recovery.universal3475.rc
LOCAL_MODULE_TAGS	:= optional
LOCAL_MODULE_CLASS	:= ETC
LOCAL_SRC_FILES		:= etc/init.recovery.universal3475.rc
LOCAL_MODULE_PATH	:= $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE		:= init.universal3475.usb.rc
LOCAL_MODULE_TAGS	:= optional
LOCAL_MODULE_CLASS	:= ETC
LOCAL_SRC_FILES		:= etc/init.universal3475.usb.rc
LOCAL_MODULE_PATH	:= $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE		:= init.universal3475.rc
LOCAL_MODULE_TAGS	:= optional
LOCAL_MODULE_CLASS	:= ETC
LOCAL_SRC_FILES		:= etc/init.universal3475.rc
LOCAL_MODULE_PATH	:= $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE		:= init.samsung.rc
LOCAL_MODULE_TAGS	:= optional
LOCAL_MODULE_CLASS	:= ETC
LOCAL_SRC_FILES		:= etc/init.samsung.rc
LOCAL_MODULE_PATH	:= $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE		:= ueventd.universal3475.rc
LOCAL_MODULE_TAGS	:= optional
LOCAL_MODULE_CLASS	:= ETC
LOCAL_SRC_FILES		:= etc/ueventd.universal3475.rc
LOCAL_MODULE_PATH	:= $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)


# audio_hal_disabled.rc - deshabilita HAL de audio AIDL que crashea
include $(CLEAR_VARS)
LOCAL_MODULE		:= audio_hal_disabled.rc
LOCAL_MODULE_TAGS	:= optional
LOCAL_MODULE_CLASS	:= ETC
LOCAL_SRC_FILES		:= ../configs/init/audio_hal_disabled.rc
LOCAL_MODULE_PATH	:= $(TARGET_OUT)/etc/init
include $(BUILD_PREBUILT)


# netd.rc - fix netd loop (elimina onrestart restart zygote, añade oneshot)
include $(CLEAR_VARS)
LOCAL_MODULE		:= netd.rc
LOCAL_MODULE_TAGS	:= optional
LOCAL_MODULE_CLASS	:= ETC
LOCAL_SRC_FILES		:= ../configs/init/netd.rc
LOCAL_MODULE_PATH	:= $(TARGET_OUT)/etc/init
include $(BUILD_PREBUILT)


# zygote_no_netd_restart.rc - elimina onrestart restart netd/wificond de zygote
include $(CLEAR_VARS)
LOCAL_MODULE		:= zygote_no_netd_restart.rc
LOCAL_MODULE_TAGS	:= optional
LOCAL_MODULE_CLASS	:= ETC
LOCAL_SRC_FILES		:= ../configs/init/zygote_no_netd_restart.rc
LOCAL_MODULE_PATH	:= $(TARGET_OUT)/etc/init
include $(BUILD_PREBUILT)


# gnss_disabled.rc - deshabilita HAL gnss que crashea
include $(CLEAR_VARS)
LOCAL_MODULE		:= gnss_disabled.rc
LOCAL_MODULE_TAGS	:= optional
LOCAL_MODULE_CLASS	:= ETC
LOCAL_SRC_FILES		:= ../configs/init/gnss_disabled.rc
LOCAL_MODULE_PATH	:= $(TARGET_OUT)/etc/init
include $(BUILD_PREBUILT)

# memtrack_disabled.rc - deshabilita HAL memtrack que crashea
include $(CLEAR_VARS)
LOCAL_MODULE		:= memtrack_disabled.rc
LOCAL_MODULE_TAGS	:= optional
LOCAL_MODULE_CLASS	:= ETC
LOCAL_SRC_FILES		:= ../configs/init/memtrack_disabled.rc
LOCAL_MODULE_PATH	:= $(TARGET_OUT)/etc/init
include $(BUILD_PREBUILT)

# sensors_disabled.rc - deshabilita HAL sensors que crashea
include $(CLEAR_VARS)
LOCAL_MODULE		:= sensors_disabled.rc
LOCAL_MODULE_TAGS	:= optional
LOCAL_MODULE_CLASS	:= ETC
LOCAL_SRC_FILES		:= ../configs/init/sensors_disabled.rc
LOCAL_MODULE_PATH	:= $(TARGET_OUT)/etc/init
include $(BUILD_PREBUILT)

