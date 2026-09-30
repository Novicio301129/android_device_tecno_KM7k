#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from device specific configuration first
$(call inherit-product, device/tecno/KM7k/device.mk)

# Inherit from LineageOS common product configuration (Full Phone with GMS/Telephony support)
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Architecture & Core System Configurations
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Device Identifier / Product Info
PRODUCT_NAME := lineage_KM7k
PRODUCT_DEVICE := KM7k
PRODUCT_BRAND := TECNO
PRODUCT_MODEL := TECNO KM7k
PRODUCT_MANUFACTURER := TECNO

# GMS Client ID Base
PRODUCT_GMS_CLIENTID_BASE := android-tecno

# Build Fingerprint and Description extracted from actual firmware dump
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="sys_tssi_64_armv82_tecno_dolby-user 15 AP3A.240905.015.A2 991845 dev-keys"

BUILD_FINGERPRINT := TECNO/FULL-64-ARMV82/TSSI:15/AP3A.240905.015/991845:user/release-keys
