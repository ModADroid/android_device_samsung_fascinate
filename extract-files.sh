#!/bin/sh

# Copyright (C) 2010 The Android Open Source Project
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

DEVICE=fascinate

rm -rf ../../../vendor/samsung/$DEVICE/*
mkdir -p ../../../vendor/samsung/$DEVICE/proprietary

if [ -f "$1" ]; then
	rm -rf tmp
	mkdir tmp
	unzip -q "$1" -d tmp
	if [ $? != 0 ]; then
		echo "$1 is not a valid zip file. Bye."
		exit 1
	fi
	echo "$1 successfully unzip'd. Copying files..."
	ZIP="true"
else
	unset ZIP
fi

DIRS="
app
bin
cameradata
etc/dhcpcd/dhcpcd-hooks
etc/ppp
etc/wifi
firmware
lib/egl
lib/hw
media
tts/lang_pico
xbin
"

for DIR in $DIRS; do
	mkdir -p ../../../vendor/samsung/$DEVICE/proprietary/$DIR
done

FILES="
bin/dhcpcd
bin/immvibed
bin/pppd
bin/pppd_runner
bin/rild
bin/rilclient-test
bin/vold
bin/wlservice
bin/wpa_supplicant
bin/pvrsrvinit
bin/sensorcalibutil_yamaha
bin/sensorstatutil_yamaha
bin/sensorserver_yamaha
bin/pv2way_omx_engine_test
bin/hciattach
bin/btld
bin/dbus-daemon
bin/BCM4329B1_002.002.023.0417.0430.hcd

cameradata/datapattern_420sp.yuv
cameradata/datapattern_front_420sp.yuv

etc/asound.conf
etc/ppp/chap-secrets
etc/ppp/ip-down
etc/ppp/ip-up
etc/ppp/ip-up-vpn
etc/ppp/options
etc/ppp/pap-secrets
etc/init.cdma-pppd
etc/init.gprs-pppd
etc/vold.conf
etc/vold.fstab
etc/wifi/nvram_net.txt
etc/wifi/nvram_mfg.txt
etc/wifi/bcm4329_aps.bin
etc/wifi/bcm4329_mfg.bin
etc/wifi/bcm4329_sta.bin
etc/wifi/wifi.conf
etc/wifi/wpa_supplicant.conf
etc/apns-conf.xml
etc/cdma-carriers-conf.xml
etc/dhcpcd/dhcpcd-hooks/01-test
etc/dhcpcd/dhcpcd-hooks/20-dns.conf
etc/dhcpcd/dhcpcd-hooks/95-configured
etc/dhcpcd/dhcpcd.conf
etc/dhcpcd/dhcpcd-run-hooks
etc/gps.conf

lib/libgps.so
lib/libsecgps.so
lib/libril.so
lib/libsec-ril40.so
lib/libreference-ril.so
lib/libsecril-client.so
lib/libwlservice.so
lib/libwpa_client.so

lib/libarccamera.so
lib/libcamerafirmwarejni.so
lib/libcamera.so
lib/libseccameraadaptor.so
lib/libseccamera.so
lib/libs3cjpeg.so
lib/libskiagl.so

lib/libhardware_legacy.so

lib/libs263domxoc.so
lib/libs263eomxoc.so
lib/libs264domxoc.so
lib/libs264eomxoc.so
lib/libsaacdomxoc.so
lib/libsaaceomxoc.so
lib/libsac3domxoc.so
lib/libsamrdomxoc.so
lib/libsamreomxoc.so
lib/libsdiv3domxoc.so
lib/libsflacdomxoc.so
lib/libsmp3domxoc.so
lib/libsmp4fmocn.so
lib/libsmp4vdomxoc.so
lib/libsmp4veomxoc.so
lib/libsvc1domxoc.so
lib/libswmadomxoc.so
lib/libswmv7domxoc.so
lib/libswmv8domxoc.so
lib/libomx_evrcdec_sharedlibrary.so
lib/libomx_evrcenc_sharedlibrary.so
lib/libomx_qcelpdec_sharedlibrary.so
lib/libomx_qcelpenc_sharedlibrary.so
lib/libomadrm.so
lib/libomx_avcenc_sharedlibrary.so
lib/libomx_m4venc_sharedlibrary.so
lib/libopencore_2way.so
lib/libsavidocn.so
lib/libsavidreg.so
lib/libsavsac.so
lib/libsavscmn.so
lib/libsavsff.so
lib/libsavsvc.so
lib/libsflacfdocn.so
lib/libsflacfdreg.so
lib/libsflvdocn.so
lib/libsflvdreg.so
lib/libsmkvdocn.so
lib/libsmkvdreg.so
lib/libswmfdocn.so
lib/libswmfdreg.so
lib/libQmageDecoder.so
lib/libquramgifmovie.so
lib/libquramimagecodec.so
lib/libquramvdecoder.so

lib/egl/libEGL_POWERVR_SGX540_120.so
lib/egl/libGLES_android.so
lib/egl/libGLESv1_CM_POWERVR_SGX540_120.so
lib/egl/libGLESv2_POWERVR_SGX540_120.so
lib/libsrv_um.so
lib/libsrv_init.so
lib/libIMGegl.so
lib/libpvr2d.so
lib/libpvrANDROID_WSEGL.so
lib/libglslcompiler.so
lib/libPVRScopeServices.so

lib/libsensor_yamaha.so
lib/libsensor_yamaha_test.so
lib/libms3c_yamaha.so
lib/hw/copybit.s5pc110.so
lib/hw/lights.s5pc110.so
lib/hw/sensors.default.so
lib/hw/gralloc.s5pc110.so

lib/libImmVibeJ.so
lib/libImmVibe.so

tts/lang_pico/en-US_lh0_sg.bin
tts/lang_pico/en-US_ta.bin
tts/lang_pico/es-ES_zl0_sg.bin
tts/lang_pico/es-ES_ta.bin

bin/playlpm
bin/charging_mode
media/battery_charging_5.qmg
media/battery_charging_10.qmg
media/battery_charging_15.qmg
media/battery_charging_20.qmg
media/battery_charging_25.qmg
media/battery_charging_30.qmg
media/battery_charging_35.qmg
media/battery_charging_40.qmg
media/battery_charging_45.qmg
media/battery_charging_50.qmg
media/battery_charging_55.qmg
media/battery_charging_60.qmg
media/battery_charging_65.qmg
media/battery_charging_70.qmg
media/battery_charging_75.qmg
media/battery_charging_80.qmg
media/battery_charging_85.qmg
media/battery_charging_90.qmg
media/battery_charging_95.qmg
media/battery_charging_100.qmg
media/batteryerror.qmg
media/chargingwarning.qmg
media/Disconnected.qmg
"

for FILE in $FILES; do
	if [ "$ZIP" ]; then
		cp tmp/system/"$FILE" ../../../vendor/samsung/$DEVICE/proprietary/$FILE
	else
		adb pull system/$FILE ../../../vendor/samsung/$DEVICE/proprietary/$FILE
	fi
done
if [ "$ZIP" ]; then rm -rf tmp ; fi

(cat << EOF) | sed s/__DEVICE__/$DEVICE/g > ../../../vendor/samsung/$DEVICE/$DEVICE-vendor-blobs.mk
# Copyright (C) 2010 The Android Open Source Project
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

# This file is generated by device/samsung/__DEVICE__/extract-files.sh

# Prebuilt libraries that are needed to build open-source libraries
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsecril-client.so:obj/lib/libsecril-client.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libcamera.so:obj/lib/libcamera.so

#
# Wifi
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/lib/libwlservice.so:system/lib/libwlservice.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libwpa_client.so:system/lib/libwpa_client.so \\
    vendor/samsung/__DEVICE__/proprietary/etc/wifi/nvram_net.txt:system/etc/wifi/nvram_net.txt \\
    vendor/samsung/__DEVICE__/proprietary/etc/wifi/nvram_mfg.txt:system/etc/wifi/nvram_mfg.txt \\
    vendor/samsung/__DEVICE__/proprietary/etc/wifi/bcm4329_aps.bin:system/etc/wifi/bcm4329_aps.bin \\
    vendor/samsung/__DEVICE__/proprietary/etc/wifi/bcm4329_mfg.bin:system/etc/wifi/bcm4329_mfg.bin \\
    vendor/samsung/__DEVICE__/proprietary/etc/wifi/bcm4329_sta.bin:system/etc/wifi/bcm4329_sta.bin \\
    vendor/samsung/__DEVICE__/proprietary/etc/wifi/wifi.conf:system/etc/wifi/wifi.conf \\
    vendor/samsung/__DEVICE__/proprietary/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \\
    vendor/samsung/__DEVICE__/proprietary/bin/wlservice:system/bin/wlservice \\
    vendor/samsung/__DEVICE__/proprietary/bin/wpa_supplicant:system/bin/wpa_supplicant

#
# Display (3D)
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/bin/pvrsrvinit:system/bin/pvrsrvinit \\
    vendor/samsung/__DEVICE__/proprietary/lib/egl/libEGL_POWERVR_SGX540_120.so:system/lib/egl/libEGL_POWERVR_SGX540_120.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/egl/libGLES_android.so:system/lib/egl/libGLES_android.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/egl/libGLESv1_CM_POWERVR_SGX540_120.so:system/lib/egl/libGLESv1_CM_POWERVR_SGX540_120.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/egl/libGLESv2_POWERVR_SGX540_120.so:system/lib/egl/libGLESv2_POWERVR_SGX540_120.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsrv_um.so:system/lib/libsrv_um.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsrv_init.so:system/lib/libsrv_init.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libIMGegl.so:system/lib/libIMGegl.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libpvr2d.so:system/lib/libpvr2d.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libpvrANDROID_WSEGL.so:system/lib/libpvrANDROID_WSEGL.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libglslcompiler.so:system/lib/libglslcompiler.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libPVRScopeServices.so:system/lib/libPVRScopeServices.so

#
# Sensors, Lights etc
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/lib/hw/sensors.default.so:system/lib/hw/sensors.default.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/hw/gralloc.s5pc110.so:system/lib/hw/gralloc.s5pc110.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsensor_yamaha.so:system/lib/libsensor_yamaha.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsensor_yamaha_test.so:system/lib/libsensor_yamaha_test.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libms3c_yamaha.so:system/lib/libms3c_yamaha.so \\
    vendor/samsung/__DEVICE__/proprietary/bin/sensorcalibutil_yamaha:system/bin/sensorcalibutil_yamaha \\
    vendor/samsung/__DEVICE__/proprietary/bin/sensorserver_yamaha:system/bin/sensorserver_yamaha \\
    vendor/samsung/__DEVICE__/proprietary/bin/sensorstatutil_yamaha:system/bin/sensorstatutil_yamaha \\
    vendor/samsung/__DEVICE__/proprietary/lib/hw/copybit.s5pc110.so:system/lib/hw/copybit.s5pc110.so

#
# Camera
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/lib/libarccamera.so:system/lib/libarccamera.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libcamerafirmwarejni.so:system/lib/libcamerafirmwarejni.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libseccameraadaptor.so:system/lib/libseccameraadaptor.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libseccamera.so:system/lib/libseccamera.so \\
    vendor/samsung/__DEVICE__/proprietary/cameradata/datapattern_420sp.yuv:system/cameradata/datapattern_420sp.yuv \\
    vendor/samsung/__DEVICE__/proprietary/cameradata/datapattern_front_420sp.yuv:system/cameradata/datapattern_front_420sp.yuv \\
    vendor/samsung/__DEVICE__/proprietary/lib/libcamera.so:system/lib/libcamera.so

#
# RIL
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsec-ril40.so:system/lib/libsec-ril40.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsecril-client.so:system/lib/libsecril-client.so \\
    vendor/samsung/__DEVICE__/proprietary/etc/cdma-carriers-conf.xml:system/etc/cdma-carriers-conf.xml \\
    vendor/samsung/__DEVICE__/proprietary/bin/dhcpcd:system/bin/dhcpcd \\
    vendor/samsung/__DEVICE__/proprietary/etc/dhcpcd/dhcpcd-hooks/01-test:system/etc/dhcpcd/dhcpcd-hooks/01-test \\
    vendor/samsung/__DEVICE__/proprietary/etc/dhcpcd/dhcpcd-hooks/20-dns.conf:system/etc/dhcpcd/dhcpcd-hooks/20-dns.conf \\
    vendor/samsung/__DEVICE__/proprietary/etc/dhcpcd/dhcpcd-hooks/95-configured:system/etc/dhcpcd/dhcpcd-hooks/95-configured \\
    vendor/samsung/__DEVICE__/proprietary/etc/dhcpcd/dhcpcd-run-hooks:system/etc/dhcpcd/dhcpcd-run-hooks \\
    vendor/samsung/__DEVICE__/proprietary/etc/dhcpcd/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf \\
    vendor/samsung/__DEVICE__/proprietary/bin/rilclient-test:system/bin/rilclient-test \\
    vendor/samsung/__DEVICE__/proprietary/bin/rild:system/bin/rild \\
    vendor/samsung/__DEVICE__/proprietary/lib/libril.so:system/lib/libril.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libreference-ril.so:system/lib/libreference-ril.so

#
# PPP
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/bin/pppd_runner:system/bin/pppd_runner \\
    vendor/samsung/__DEVICE__/proprietary/etc/init.cdma-pppd:system/etc/init.cdma-pppd \\
    vendor/samsung/__DEVICE__/proprietary/etc/init.gprs-pppd:system/etc/init.gprs-pppd \\
    vendor/samsung/__DEVICE__/proprietary/etc/ppp/chap-secrets:system/etc/ppp/chap-secrets \\
    vendor/samsung/__DEVICE__/proprietary/etc/ppp/ip-up:system/etc/ppp/ip-up \\
    vendor/samsung/__DEVICE__/proprietary/etc/ppp/ip-down:system/etc/ppp/ip-down \\
    vendor/samsung/__DEVICE__/proprietary/etc/ppp/ip-up-vpn:system/etc/ppp/ip-up-vpn \\
    vendor/samsung/__DEVICE__/proprietary/etc/ppp/pap-secrets:system/etc/ppp/pap-secrets \\
    vendor/samsung/__DEVICE__/proprietary/etc/ppp/options:system/etc/ppp/options

#
# OMX
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/lib/libs263domxoc.so:system/lib/libs263domxoc.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libs263eomxoc.so:system/lib/libs263eomxoc.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libs264domxoc.so:system/lib/libs264domxoc.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libs264eomxoc.so:system/lib/libs264eomxoc.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsaacdomxoc.so:system/lib/libsaacdomxoc.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsaaceomxoc.so:system/lib/libsaaceomxoc.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsac3domxoc.so:system/lib/libsac3domxoc.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsamrdomxoc.so:system/lib/libsamrdomxoc.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsamreomxoc.so:system/lib/libsamreomxoc.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsdiv3domxoc.so:system/lib/libsdiv3domxoc.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsflacdomxoc.so:system/lib/libsflacdomxoc.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsmp3domxoc.so:system/lib/libsmp3domxoc.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsmp4fmocn.so:system/lib/libsmp4fmocn.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsmp4vdomxoc.so:system/lib/libsmp4vdomxoc.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsmp4veomxoc.so:system/lib/libsmp4veomxoc.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsvc1domxoc.so:system/lib/libsvc1domxoc.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libswmadomxoc.so:system/lib/libswmadomxoc.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libswmv7domxoc.so:system/lib/libswmv7domxoc.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libswmv8domxoc.so:system/lib/libswmv8domxoc.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libomx_evrcdec_sharedlibrary.so:system/lib/libomx_evrcdec_sharedlibrary.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libomx_evrcenc_sharedlibrary.so:system/lib/libomx_evrcenc_sharedlibrary.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libomx_qcelpdec_sharedlibrary.so:system/lib/libomx_qcelpdec_sharedlibrary.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libomx_qcelpenc_sharedlibrary.so:system/lib/libomx_qcelpenc_sharedlibrary.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libomadrm.so:system/lib/libomadrm.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libomx_avcenc_sharedlibrary.so:system/lib/libomx_avcenc_sharedlibrary.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libomx_m4venc_sharedlibrary.so:system/lib/libomx_m4venc_sharedlibrary.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libopencore_2way.so:system/lib/libopencore_2way.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsavidocn.so:system/lib/libsavidocn.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsavidreg.so:system/lib/libsavidreg.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsavsac.so:system/lib/libsavsac.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsavscmn.so:system/lib/libsavscmn.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsavsff.so:system/lib/libsavsff.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsavsvc.so:system/lib/libsavsvc.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsflacfdocn.so:system/lib/libsflacfdocn.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsflacfdreg.so:system/lib/libsflacfdreg.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsflvdocn.so:system/lib/libsflvdocn.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsflvdreg.so:system/lib/libsflvdreg.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsmkvdocn.so:system/lib/libsmkvdocn.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsmkvdreg.so:system/lib/libsmkvdreg.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libswmfdocn.so:system/lib/libswmfdocn.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libswmfdreg.so:system/lib/libswmfdreg.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libQmageDecoder.so:system/lib/libQmageDecoder.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libquramgifmovie.so:system/lib/libquramgifmovie.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libquramimagecodec.so:system/lib/libquramimagecodec.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libquramvdecoder.so:system/lib/libquramvdecoder.so

#
# Voice Search
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/tts/lang_pico/en-US_lh0_sg.bin:system/tts/lang_pico/en-US_lh0_sg.bin \\
    vendor/samsung/__DEVICE__/proprietary/tts/lang_pico/en-US_ta.bin:system/tts/lang_pico/en-US_ta.bin \\
    vendor/samsung/__DEVICE__/proprietary/tts/lang_pico/es-ES_zl0_sg.bin:system/tts/lang_pico/es-ES_zl0_sg.bin \\
    vendor/samsung/__DEVICE__/proprietary/tts/lang_pico/es-ES_ta.bin:system/tts/lang_pico/es-ES_ta.bin

#
# Other stuff
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/bin/immvibed:system/bin/immvibed \\
    vendor/samsung/__DEVICE__/proprietary/lib/libImmVibeJ.so:system/lib/libImmVibeJ.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libImmVibe.so:system/lib/libImmVibe.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libskiagl.so:system/lib/libskiagl.so \\
    vendor/samsung/__DEVICE__/proprietary/bin/BCM4329B1_002.002.023.0417.0430.hcd:system/bin/BCM4329B1_002.002.023.0417.0430.hcd \\
    vendor/samsung/__DEVICE__/proprietary/bin/vold:system/bin/vold \\
    vendor/samsung/__DEVICE__/proprietary/etc/vold.conf:system/etc/vold.conf \\
    vendor/samsung/__DEVICE__/proprietary/etc/vold.fstab:system/etc/vold.fstab \\
    vendor/samsung/__DEVICE__/proprietary/lib/libhardware_legacy.so:system/lib/libhardware_legacy.so

#
# Files for battery charging screen
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/bin/playlpm:system/bin/playlpm \\
    vendor/samsung/__DEVICE__/proprietary/bin/charging_mode:system/bin/charging_mode \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_5.qmg:system/media/battery_charging_5.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_10.qmg:system/media/battery_charging_10.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_15.qmg:system/media/battery_charging_15.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_20.qmg:system/media/battery_charging_20.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_25.qmg:system/media/battery_charging_25.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_30.qmg:system/media/battery_charging_30.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_35.qmg:system/media/battery_charging_35.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_40.qmg:system/media/battery_charging_40.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_45.qmg:system/media/battery_charging_45.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_50.qmg:system/media/battery_charging_50.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_55.qmg:system/media/battery_charging_55.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_60.qmg:system/media/battery_charging_60.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_65.qmg:system/media/battery_charging_65.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_70.qmg:system/media/battery_charging_70.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_75.qmg:system/media/battery_charging_75.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_80.qmg:system/media/battery_charging_80.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_85.qmg:system/media/battery_charging_85.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_90.qmg:system/media/battery_charging_90.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_95.qmg:system/media/battery_charging_95.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_100.qmg:system/media/battery_charging_100.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/batteryerror.qmg:system/media/batteryerror.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/chargingwarning.qmg:system/media/chargingwarning.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/Disconnected.qmg:system/media/Disconnected.qmg

EOF

./setup-makefiles.sh
