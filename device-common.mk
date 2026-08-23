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

DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# Audio policy XML (formato moderno; el .conf legacy ya no se copia en T).
# TODO(fase 4): regenerar audio_policy_configuration.xml a version 7.0.
PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml \
    $(LOCAL_PATH)/configs/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml

# Bluetooth — HAL HIDL 1.0 custom del common (enfoque Exynos7420).
# P-1 (22/08): libbt-vendor retirado del PRODUCT_PACKAGES — sin definición de
# módulo ni blob verificable en el árbol/vendor. El impl.3475 lo carga por
# dlopen en runtime (VENDOR_LIBRARY_NAME), no lo enlaza en build, así que el
# build no se afecta; BT quedará inoperativo hasta la fase Bluetooth/vendor,
# donde se localizará el .so y se agregará a proprietary-files.txt.
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0-impl.3475

# Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.4-impl-legacy \
    android.hardware.camera.provider@2.4-service

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm@1.0-impl \
    android.hardware.drm@1.0-service \
    android.hardware.drm-service.clearkey

# Flat device tree for boot image
PRODUCT_HOST_PACKAGES += \
    dtbhtoolExynos

# GPS
PRODUCT_PACKAGES += \
    android.hardware.gnss@1.0-impl \
    android.hardware.gnss@1.0-service

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/gps/gps.conf:system/etc/gps.conf \
    $(LOCAL_PATH)/configs/gps/gps.xml:system/etc/gps.xml

# Graphics — stack SLSI exynos5 legacy con adapters (receta 7420).
# TODO(fase 2): validar compilación contra hardware/samsung_slsi actualizado.
PRODUCT_PACKAGES += \
    libion \
    libfimg \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.allocator@2.0-service \
    android.hardware.graphics.composer@2.1-service \
    android.hardware.graphics.mapper@2.0-impl-2.1 \
    libhwc2on1adapter

# Health 2.1
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service

# Keymaster 3.0 + keystore TEE (blobs mobicore intactos)
PRODUCT_PACKAGES += \
    keystore.exynos7570 \
    android.hardware.keymaster@3.0-impl \
    android.hardware.keymaster@3.0-service

# Lights — FIX-024: android.hardware.light@2.0-service.samsung NO existe en
# hardware/samsung lineage-20 (sin dir lights). LIMITACIÓN: sin HAL de lights
# hasta portar/crear uno (no crítico para boot).

# Media
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    $(LOCAL_PATH)/configs/media/media_codecs_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml \
    $(LOCAL_PATH)/configs/media/media_profiles_V1_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_video_le.xml

# OMX service (implementa android.hardware.media.omx@1.0 declarado en
# manifest.xml; modulo en frameworks/av services/mediacodec, vendor 32-bit)
PRODUCT_PACKAGES += \
    android.hardware.media.omx@1.0-service

# Memory
PRODUCT_PACKAGES += \
    android.hardware.memtrack@1.0-impl \
    android.hardware.memtrack@1.0-service

# Mobicore (TEE)
PRODUCT_PACKAGES += \
    mcDriverDaemon \
    libMcClient \
    libMcRegistry

# Power — FIX-024: power@1.0-service.exynos NO existe en LOS20 (verificado
# org:LineageOS). LIMITACIÓN: sin HAL de power hasta decidir reemplazo
# (p.ej. power-service.samsung-libperfmgr); no crítico para boot.

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml

# ramdisk
PRODUCT_PACKAGES += \
    init.power.rc \
    fstab.universal3475 \
    init.baseband.rc \
    init.samsung.rc \
    init.universal3475.rc \
    init.universal3475.usb.rc \
    init.recovery.universal3475.rc \
    init.wifi.rc \
    ueventd.universal3475.rc

# SamsungDoze
PRODUCT_PACKAGES += \
    SamsungDoze

# SEC
PRODUCT_PACKAGES += \
    libsecnativefeature

# Seccomp filters
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/seccomp/mediaextractor-seccomp.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediaextractor.policy \
    $(LOCAL_PATH)/seccomp/mediacodec-seccomp.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediacodec.policy

# Sensors / Vibrator
PRODUCT_PACKAGES += \
    android.hardware.sensors@1.0-impl \
    android.hardware.sensors@1.0-service \
    android.hardware.vibrator@1.0-impl \
    android.hardware.vibrator@1.0-service

# Shims
# FIX-002 (22/08): solo se declara libstagefright_shim, unico modulo con
# definicion local (libshims/libstagefright). libcamera_client_shim,
# libexynoscamera_shim y libui_shim no tienen fuente ni blob -> riesgo
# "missing module". Las entradas LD_SHIM_LIBS asociadas quedan inoperativas
# (config-only) hasta la fase camara/graficos.
# FIX-022: libstdc++ ya NO es shim propio — bionic/libc de lineage-20.0
# define cc_library "libstdc++" (vendor_available) con new.cpp,
# __cxa_guard.cpp y __cxa_pure_virtual.cpp: cubre operadores, pure_virtual Y
# guards que los blobs legacy necesitan (sensors/camera/sec-ril).
# FIX-021: libhardware_legacy ya NO es shim propio — LineageOS lineage-20.0
# mantiene hardware/libhardware_legacy (cc_library_shared vendor_available+VNDK)
# con las mismas acquire/release_wake_lock que gpsd consume (auditoría UND
# FIX-008). El PRODUCT_PACKAGES de abajo instala ahora el módulo upstream.
# FIX-020: libhidltransport eliminada del BT HAL (fusionada en libhidlbase en R).
PRODUCT_PACKAGES += \
    libstagefright_shim \
    libhardware_legacy

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb@1.0-service.basic

# Wi-Fi — bcmdhd (driver NL80211 en kernel) + supplicant/hostapd.
# FIX-017: android.hardware.wifi@1.0-{service,impl} NO existen en
# hardware/interfaces lineage-20.0 (solo definiciones .hal) -> eliminados
# ("missing module" garantizado). Los servicios reales de LOS20 son AIDL y los
# provee external/wpa_supplicant_8 (CONFIG_CTRL_IFACE_AIDL=y por defecto en
# android.config), que instala sus propios VINTF fragments
# (android.hardware.wifi.{hostapd,supplicant}.xml, fqname default).
# LIMITACION CONOCIDA: sin HAL de chip (IWifiChip) el WiFi puede quedar no
# funcional hasta una fase futura; igual que BT, no bloquea el build.
PRODUCT_PACKAGES += \
    macloader \
    wifiloader \
    hostapd \
    wificond \
    wpa_supplicant \
    wpa_supplicant.conf

# Wi-Fi Configs
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/wifi/p2p_supplicant_overlay.conf:system/vendor/etc/wifi/p2p_supplicant_overlay.conf \
    $(LOCAL_PATH)/configs/wifi/wpa_supplicant_overlay.conf:system/vendor/etc/wifi/wpa_supplicant_overlay.conf

# Control groups y task profiles para kernels legacy (imprescindible en T;
# referenciado por init de A13). Contenido orientado a kernel 3.10.
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/cgroups.json:$(TARGET_COPY_OUT_VENDOR)/etc/cgroups.json \
    $(LOCAL_PATH)/configs/task_profiles.json:$(TARGET_COPY_OUT_VENDOR)/etc/task_profiles.json

# Particiones: dispositivo no-A/B legacy
$(call inherit-product, $(SRC_TARGET_DIR)/product/non_ab_device.mk)

# NOTA (eliminado respecto a 17.1):
#   - props ro.secure=0 / ro.adb.secure=0 / ro.debuggable=1 (inseguras)
#   - configstore (eliminado en A12; usar disable_configstore si hace falta)
#   - renderscript HAL (deprecado en T)
#   - textclassifier.bundle1
#   - vendor.lineage.trust@1.0-service (retirado del árbol Lineage reciente;
#     la entrada VINTF correspondiente quedó marcada TODO en manifest.xml)
#   - tv.input
#   - audio_policy.conf (formato muerto en T)

# call Samsung LSI board support package
$(call inherit-product, hardware/samsung_slsi/exynos5/exynos5.mk)
$(call inherit-product, hardware/samsung_slsi/exynos3475/exynos3475.mk)

# call the proprietary setup
$(call inherit-product, vendor/samsung/universal3475-common/universal3475-common-vendor.mk)
