#
# Copyright (C) 2018-2026 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

LOCAL_PATH := device/samsung/universal3475-common
BUILD_TOP := $(shell pwd)

BUILD_BROKEN_DUP_RULES := true
# Los blobs legacy se copian como prebuilts product; necesario en T.
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# Include path
TARGET_SPECIFIC_HEADER_PATH := $(LOCAL_PATH)/include

# Firmware
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Platform (Exynos3475 — ARMv7 Cortex-A7, 32-bit puro)
TARGET_BOARD_PLATFORM := exynos5
TARGET_SLSI_VARIANT := bsp
TARGET_SOC := exynos3475
TARGET_BOOTLOADER_BOARD_NAME := universal3475
BOARD_VENDOR := samsung

# Binder (32-bit only — no aplicar TARGET_USES_64_BIT_BINDER)

# CPU
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := cortex-a7

# Modelo bootimg del J2 (FIX-028): el kernel compila zImage-dtb
# (CONFIG_BUILD_ARM_APPENDED_DTB_IMAGE=y, defconfig:530) => los DTB van
# DENTRO del zImage. No hay dt.img separado ni dtbtool (eliminado de
# lineage-20.0). mkbootimg.mk sigue usándose por SEANDROIDENFORCE.
BOARD_CUSTOM_BOOTIMG := true
BOARD_CUSTOM_BOOTIMG_MK := hardware/samsung/mkbootimg.mk
BOARD_MKBOOTIMG_ARGS := --kernel_offset 0x00008000 --ramdisk_offset 0x01000000 --tags_offset 0x00000100
BOARD_KERNEL_BASE := 0x10000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_IMAGE_NAME := zImage-dtb
# FIX-034: recovery.img excedía la partición en ~446KB con gzip; xz reduce
# el ramdisk sustancialmente (soporte nativo build/make core/Makefile:894).
BOARD_RAMDISK_USE_XZ := true
# BOARD_KERNEL_CMDLINE: el bootloader ignora el cmdline del boot.img
BOARD_KERNEL_SEPARATED_DT := false
BOARD_ROOT_EXTRA_FOLDERS += efs cpefs
TARGET_FS_CONFIG_GEN := $(LOCAL_PATH)/config.fs

# Kernel (Linux 3.10.9 BSP Samsung)
TARGET_KERNEL_ARCH := arm
TARGET_LINUX_KERNEL_VERSION := 3.10
TARGET_KERNEL_SOURCE := kernel/samsung/exynos3475
# Compilación con clang moderno (referencia Exynos7420 LOS20: clang r416183b).
# TODO(fase 1): ajustar versión de clang y completar backports (eBPF, binder
# freezer, renameat2, shrinker). El defconfig actual aún es el de 17.1.
TARGET_KERNEL_CLANG := true
TARGET_KERNEL_CLANG_VERSION := r450784d
TARGET_KERNEL_LLVM_BINUTILS := false
TARGET_KERNEL_ADDITIONAL_FLAGS += \
    HOSTCFLAGS="-fuse-ld=lld -Wno-unused-command-line-argument"

# Filesystem
BOARD_HAS_LARGE_FILESYSTEM := true
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4

# Vendor separation — validado viable en T por el porte Exynos7420.
TARGET_COPY_OUT_VENDOR := system/vendor

# Device Tree
BOARD_USES_DT := true

# VINTF — estrategia legacy: manifest target-level=3 (FCM R) con HALs HIDL.
DEVICE_MANIFEST_FILE += device/samsung/j2lte/manifest.xml
# FIX-036: sin DEVICE_MATRIX_FILE propio -> libhidl usa su
# device_compatibility_matrix.default.xml (la ruta con $(LOCAL_PATH)
# resolvía contaminada a system/libhidl/vintfdata y rompía Ninja).
# DEVICE_MANIFEST_FILE arriba sí usa ruta TOP-explícita.
PRODUCT_ENFORCE_VINTF_MANIFEST_OVERRIDE := true

# Graphics
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
BOARD_USES_EXYNOS5_COMMON_GRALLOC := true

# Samsung OpenMAX (TODO fase 4: evaluar migración Codec2; flags conservados
# porque los makefiles SLSI siguen consumiéndolos).
BOARD_USE_STOREMETADATA := true
BOARD_USE_METADATABUFFERTYPE := true
BOARD_USE_DMA_BUF := true
BOARD_USE_ANB_OUTBUF_SHARE := true
BOARD_USE_IMPROVED_BUFFER := true
BOARD_USE_NON_CACHED_GRAPHICBUFFER := true
BOARD_USE_GSC_RGB_ENCODER := true
BOARD_USE_CSC_HW := false
BOARD_USE_QOS_CTRL := false
BOARD_USE_S3D_SUPPORT := true
BOARD_USE_TIMESTAMP_REORDER_SUPPORT := false
BOARD_USE_DEINTERLACING_SUPPORT := false
BOARD_USE_VP8ENC_SUPPORT := true
BOARD_USE_HEVCDEC_SUPPORT := true
BOARD_USE_HEVCENC_SUPPORT := true
BOARD_USE_HEVC_HWIP := false
BOARD_USE_VP9DEC_SUPPORT := true
BOARD_USE_VP9ENC_SUPPORT := false
BOARD_USE_CUSTOM_COMPONENT_SUPPORT := true
BOARD_USE_VIDEO_EXT_FOR_WFD_HDCP := false
BOARD_USE_SINGLE_PLANE_IN_DRM := false

# HWComposer
BOARD_USES_VPP := true
BOARD_HDMI_INCAPABLE := true

# Scalar
BOARD_USES_SCALER := true

# WiFiDisplay
BOARD_USES_VIRTUAL_DISPLAY_DECON_EXT_WB := false
BOARD_USE_VIDEO_EXT_FOR_WFD_DRM := false
BOARD_USES_VDS_BGRA8888 := true
BOARD_VIRTUAL_DISPLAY_DISABLE_IDMA_G0 := false

# LIBHWJPEG
TARGET_USES_UNIVERSAL_LIBHWJPEG := true

# FIMG2D
BOARD_USES_SKIA_FIMGAPI := true
BOARD_USES_FIMGAPI_V5X := true

# SCALER
BOARD_USES_DEFAULT_CSC_HW_SCALER := true
BOARD_USES_SCALER_M2M1SHOT := true

# Samsung HALs
TARGET_AUDIOHAL_VARIANT := samsung
TARGET_POWERHAL_VARIANT := samsung
AUDIOSERVER_MULTILIB := 32

# Sensors
TARGET_NO_SENSOR_PERMISSION_CHECK := true

# Wifi — receta bcmdhd validada en LOS 20 por universal7420:
# VER_0_8_X se mantiene, pero con la interfaz HIDL de wpa_supplicant.
BOARD_WLAN_DEVICE := bcmdhd
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
WPA_SUPPLICANT_VERSION := VER_0_8_X
# FIX-017: WPA_SUPPLICANT_USE_HIDL retirado — variable muerta en LOS20
# (external_wpa_supplicant_8 lineage-20.0 solo implementa la ruta AIDL).
WIFI_BAND := 802_11_ABG
WIFI_DRIVER_MODULE_ARG      := "firmware_path=/vendor/etc/wifi/bcmdhd_sta.bin nvram_path=/vendor/etc/wifi/nvram_net.txt"
WIFI_DRIVER_MODULE_AP_ARG   := "firmware_path=/vendor/etc/wifi/bcmdhd_apsta.bin nvram_path=/vendor/etc/wifi/nvram_net.txt"
WIFI_DRIVER_FW_PATH_PARAM   := "/sys/module/dhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_STA     := "/vendor/etc/wifi/bcmdhd_sta.bin"
WIFI_DRIVER_FW_PATH_AP      := "/vendor/etc/wifi/bcmdhd_apsta.bin"
WIFI_DRIVER_NVRAM_PATH_PARAM:= "/sys/module/dhd/parameters/nvram_path"
WIFI_DRIVER_NVRAM_PATH      := "/vendor/etc/wifi/nvram_net.txt"
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true

# MACLOADER
BOARD_HAVE_SAMSUNG_WIFI          := true

# Bluetooth
BOARD_CUSTOM_BT_CONFIG := $(LOCAL_PATH)/bluetooth/libbt_vndcfg.txt
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_HAVE_SAMSUNG_BLUETOOTH := true

# Backlight
BACKLIGHT_PATH := "/sys/class/backlight/panel/brightness"

# Recovery
TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/ramdisk/etc/fstab.universal3475

# SELinux
# Estructura LOS20: policies del device en sepolicy/vendor.
# TODO(fase 3+): nuncaallows de plataforma 33 sin resolver — durante el porte
# se permite ignorarlos (mismo enfoque que Exynos7420) hasta endurecer.
BOARD_VENDOR_SEPOLICY_DIRS += $(LOCAL_PATH)/sepolicy/vendor
SELINUX_IGNORE_NEVERALLOWS := true

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += $(LOCAL_PATH)

# Shim
# TODO(fase 4): revisar cuando se resuelva la migración media/Codec2.
TARGET_LD_SHIM_LIBS += \
    /system/bin/mediaserver|/system/lib/libstagefright_shim.so

# System properties comunes
# FIX-032: $(LOCAL_PATH) en contexto BoardConfig = build/make/core
TARGET_SYSTEM_PROP += device/samsung/universal3475-common/system.prop

# NOTA (eliminado respecto a 17.1):
#   BOARD_SEPOLICY_DIRS / BOARD_SEPOLICY_VERS -> reemplazados por
#   BOARD_VENDOR_SEPOLICY_DIRS (la versión se sigue a la plataforma T).
