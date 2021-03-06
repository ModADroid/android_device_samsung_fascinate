#
# Copyright (C) 2009 The Android Open Source Project
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

#
# This is the product configuration for a generic GSM passion,
# not specialized for any geography.
#
$(call inherit-product, $(SRC_TARGET_DIR)/product/small_base.mk)

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

## (1) First, the most specific values, i.e. the aspects that are specific to GSM
PRODUCT_COPY_FILES += \
    device/samsung/fascinate/prebuilt/etc/apns-conf.xml:system/etc/apns-conf.xml

## (2) Also get non-open-source GSM-specific aspects if available
$(call inherit-product-if-exists, vendor/samsung/fascinate/fascinate-vendor.mk)

## (3)  Finally, the least specific parts, i.e. the non-GSM-specific aspects
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=240 \
    rild.libpath=/system/lib/libsec-ril40.so \
    rild.libargs=-d[SPACE]/dev/ttyS0 \
    wifi.interface=eth0 \
    wifi.supplicant_scan_interval=90 \
    ro.wifi.channels=11 \
    ro.opengles.version=131072

#verizon cdma stuff
PRODUCT_PROPERTY_OVERRIDES += \
	ro.telephony.default_network=4 \
	ro.com.android.wifi-watchlist=GoogleGuest \
	ro.error.receiver.system.apps=com.google.android.feedback \
	ro.setupwizard.enterprise_mode=1 \
	ro.com.google.clientidbase=android-verizon \
	ro.com.google.clientidbase.yt=android-verizon \
	ro.com.google.clientidbase.am=android-verizon \
	ro.com.google.clientidbase.vs=android-verizon \
	ro.com.google.clientidbase.gmm=android-verizon \
	ro.com.google.locationfeatures=1 \
	ro.ril.def.agps.mode=2 \
	ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
	ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
	ro.cdma.home.operator.numeric=310004 \
	ro.cdma.home.operator.alpha=Verizon \
	ro.cdma.homesystem=64,65,76,77,78,79,80,81,82,83 \
	ro.cdma.data_retry_config=default_randomization=2000,0,0,120000,180000,540000,960000 \
	net.dns1=8.8.8.8 \
	net.dns2=8.8.4.4 \
	ro.config.vc_call_vol_steps=15 \
	ro.cdma.otaspnumschema=SELC,1,80,99 \
	ro.telephony.call_ring.multiple=false \
	ro.telephony.call_ring.delay=3000 \
	ro.telephony.call_ring.absent=true \
	net.cdma.pppd.authtype=require-chap \
	net.cdma.pppd.user=user[SPACE]VerizonWireless \
	net.cdma.datalinkinterface=/dev/ttyCDMA0 \
	net.interfaces.defaultroute=cdma \
	net.cdma.ppp.interface=ppp0 \
	net.connectivity.type=CDMA1 \
	net.interfaces.defaultroute=cdma \
	ro.csc.sales_code=VZW \
	ril.sales_code=VZW \
	ro.carrier=Verizon \
	ro.sms.padding=1

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.startheapsize=8m \
    dalvik.vm.heapsize=48m

# For mobiledatainterfaces
PRODUCT_PROPERTY_OVERRIDES += \
    mobiledata.interfaces=eth0,ppp0

# Fascinate uses high-density artwork where available
PRODUCT_LOCALES := hdpi

DEVICE_PACKAGE_OVERLAYS += device/samsung/fascinate/overlay

# media profiles and capabilities spec
PRODUCT_PROPERTY_OVERRIDES += \
      media.a1026.nsForVoiceRec=0 \
      media.a1026.enableA1026=1

# media config xml file
PRODUCT_COPY_FILES += \
    device/samsung/fascinate/prebuilt/etc/media_profiles.xml:system/etc/media_profiles.xml

# other stuffs
PRODUCT_COPY_FILES += \
    device/samsung/fascinate/prebuilt/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
    device/samsung/fascinate/prebuilt/app/FlashPlayer.apk:system/app/FlashPlayer.apk \
    device/samsung/fascinate/prebuilt/xbin/redbend_ua:system/xbin/redbend_ua \
    device/samsung/fascinate/prebuilt/xbin/strace:system/xbin/strace \
    device/samsung/fascinate/prebuilt/xbin/bmlunlock:system/xbin/bmlunlock \
    device/samsung/fascinate/prebuilt/xbin/rw:system/xbin/rw \
    device/samsung/fascinate/prebuilt/xbin/ro:system/xbin/ro

# vold
PRODUCT_COPY_FILES += \
    device/samsung/fascinate/prebuilt/etc/vold.conf:system/etc/vold.conf \
    device/samsung/fascinate/prebuilt/etc/vold.fstab:system/etc/vold.fstab

# asound.conf
PRODUCT_COPY_FILES += \
    device/samsung/fascinate/prebuilt/etc/asound.conf:system/etc/asound.conf

# Install the features available on this device.
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/base/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/base/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/base/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml

# Keylayout / Keychars
PRODUCT_COPY_FILES += \
     device/samsung/fascinate/prebuilt/usr/keylayout/s3c-keypad.kl:system/usr/keylayout/s3c-keypad.kl \
     device/samsung/fascinate/prebuilt/usr/keylayout/sec_jack.kl:system/usr/keylayout/sec_jack.kl \
     device/samsung/fascinate/prebuilt/usr/keylayout/AVRCP.kl:system/usr/keylayout/AVRCP.kl \
     device/samsung/fascinate/prebuilt/usr/keylayout/melfas-touchkey.kl:system/usr/keylayout/melfas-touchkey.kl \
     device/samsung/fascinate/prebuilt/usr/keylayout/qwerty.kl:system/usr/keylayout/qwerty.kl \
     device/samsung/fascinate/prebuilt/usr/keychars/s3c-keypad.kcm.bin:system/usr/keychars/s3c-keypad.kcm.bin \
     device/samsung/fascinate/prebuilt/usr/keychars/sec_jack.kcm.bin:system/usr/keychars/sec_jack.kcm.bin \
     device/samsung/fascinate/prebuilt/usr/keychars/melfas-touchkey.kcm.bin:system/usr/keychars/melfas-touchkey.kcm.bin \
     device/samsung/fascinate/prebuilt/usr/keychars/qwerty.kcm.bin:system/usr/keychars/qwerty.kcm.bin \
     device/samsung/fascinate/prebuilt/usr/keychars/qwerty2.kcm.bin:system/usr/keychars/qwerty2.kcm.bin  

# These are the OpenMAX IL configuration files
PRODUCT_COPY_FILES += \
    device/samsung/common/sec_mm/sec_omx/sec_omx_core/secomxregistry:system/etc/secomxregistry

# These are the OpenMAX IL modules
PRODUCT_PACKAGES += \
    libSEC_OMX_Core \
    libOMX.SEC.AVC.Decoder \
    libOMX.SEC.M4V.Decoder \
    libOMX.SEC.M4V.Encoder \
    libOMX.SEC.AVC.Encoder

# Libs
PRODUCT_PACKAGES += \
    libaudio \
    libaudiopolicy \
    sec_mm \
    libstagefrighthw \
    copybit.s5pc110 \
    lights.s5pc110 \
    overlay.s5pc110 \
    gps.aries
#    libs3cjpeg \
#    libcamera \

# camera stuff from i9000 GB
PRODUCT_COPY_FILES += \
     device/samsung/fascinate/prebuilt/bin/tvoutserver:system/bin/tvoutserver \
     device/samsung/fascinate/prebuilt/cameradata/datapattern_420sp.yuv:system/cameradata/datapattern_420sp.yuv \
     device/samsung/fascinate/prebuilt/cameradata/datapattern_front_420sp.yuv:system/cameradata/datapattern_front_420sp.yuv \
     device/samsung/fascinate/prebuilt/lib/libcamera.so:obj/lib/libcamera.so \
     device/samsung/fascinate/prebuilt/lib/libcamera.so:system/lib/libcamera.so \
     device/samsung/fascinate/prebuilt/lib/libcamera_client.so:system/lib/libcamera.so \
     device/samsung/fascinate/prebuilt/lib/libActionShot.so:system/lib/libActionShot.so \
     device/samsung/fascinate/prebuilt/lib/libCaMotion.so:system/lib/libCaMotion.so \
     device/samsung/fascinate/prebuilt/lib/libcaps.so:system/lib/libcaps.so \
     device/samsung/fascinate/prebuilt/lib/libPanoraMax1.so:system/lib/libPanoraMax1.so \
     device/samsung/fascinate/prebuilt/lib/libPlusMe.so:system/lib/libPlusMe.so \
     device/samsung/fascinate/prebuilt/lib/libarccamera.so:system/lib/libarccamera.so \
     device/samsung/fascinate/prebuilt/lib/libcamerafirmwarejni.so:system/lib/libcamerafirmwarejni.so \
     device/samsung/fascinate/prebuilt/lib/libcameraservice.so:system/lib/libcameraservice.so \
     device/samsung/fascinate/prebuilt/lib/libseccamera.so:system/lib/libseccamera.so \
     device/samsung/fascinate/prebuilt/lib/libseccameraadaptor.so:system/lib/libseccameraadaptor.so \
     device/samsung/fascinate/prebuilt/lib/libs3cjpeg.so:system/lib/libs3cjpeg.so \
     device/samsung/fascinate/prebuilt/lib/libtvout.so:system/lib/libtvout.so \
     device/samsung/fascinate/prebuilt/lib/libtvoutservice.so:system/lib/libtvoutservice.so \
     device/samsung/fascinate/prebuilt/lib/lib_tvoutengine.so:system/lib/lib_tvoutengine.so \
     device/samsung/fascinate/prebuilt/lib/libtvoutfimc.so:system/lib/libtvoutfimc.so \
     device/samsung/fascinate/prebuilt/lib/libtvouthdmi.so:system/lib/libtvouthdmi.so \
     device/samsung/fascinate/prebuilt/lib/libsecjpegencoder.so:system/lib/libsecjpegencoder.so

# Kernel
ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/samsung/fascinate/kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

$(call inherit-product, build/target/product/full.mk)

PRODUCT_NAME := full_fascinate
PRODUCT_DEVICE := fascinate
PRODUCT_MODEL := fascinate
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := Samsung
PRODUCT_POLICY := android.policy_phone

PRODUCT_PROPERTY_OVERRIDES += \
	dalvik.vm.execution-mode=int:jit

