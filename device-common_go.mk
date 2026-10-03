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

# Android Go / low-RAM recommended defaults, portados para el J2 (1 GB RAM).
# Heredado desde device-common.mk.

# (1-2-3) Dexpreopt con perfil: SOLO tienen efecto con dexpreopt activo.
# El workflow fuerza WITH_DEXPREOPT=false, así que quedan inertes hasta que
# eso cambie; se dejan listas por si se activa.
ifeq ($(WITH_DEXPREOPT),true)
# Speed profile services and wifi-service to reduce RAM and storage.
PRODUCT_SYSTEM_SERVER_COMPILER_FILTER := speed-profile
# Always preopt extracted APKs (módulos gms).
PRODUCT_ALWAYS_PREOPT_EXTRACTED_APK := true
# Profile-based boot image.
PRODUCT_USE_PROFILE_FOR_BOOT_IMAGE := true
PRODUCT_DEX_PREOPT_BOOT_IMAGE_PROFILE_LOCATION := frameworks/base/config/boot-image-profile.txt
endif

# (4) Do not generate libartd.
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# (5) In-process network stack: no separate processes for the network stack on
# low-RAM devices (saves RAM and storage).
PRODUCT_PACKAGES += \
    InProcessNetworkStack \
    com.android.tethering.inprocess

# (6) Strip the local variable table and the local variable type table to reduce
# the size of the system image. HDWP/JDWP only; no effect on stack traces.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# (7) Use Svelte memory allocator for 1GB RAM to prevent virtual memory
# exhaustion. MALLOC_SVELTE es variable de BoardConfig: se define en
# BoardConfigCommon.mk (en un .mk de producto sería un no-op).
