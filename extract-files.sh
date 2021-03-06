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
etc/wifi
firmware
lib/egl
lib/hw
media
seh
tts/lang_pico
"

for DIR in $DIRS; do
	mkdir -p ../../../vendor/samsung/$DEVICE/proprietary/$DIR
done

FILES="
bin/pvrsrvinit
bin/sensorcalibutil_yamaha
bin/sensorstatutil_yamaha
bin/sensorserver_yamaha
bin/BCM4329B1_002.002.023.0417.0430.hcd
bin/logwrapper
bin/killmediaserver
bin/netcfg

cameradata/datapattern_420sp.yuv
cameradata/datapattern_front_420sp.yuv
seh/CE147F00.bin
seh/CE147F01.bin
seh/CE147F02.bin
seh/CE147F03.bin

etc/wifi/nvram_net.txt
etc/wifi/nvram_mfg.txt
etc/wifi/bcm4329_aps.bin
etc/wifi/bcm4329_mfg.bin
etc/wifi/bcm4329_sta.bin

lib/libgps.so
lib/libsecgps.so
lib/libril.so
lib/libsec-ril40.so
lib/libsecril-client.so

lib/libarccamera.so
lib/libcamerafirmwarejni.so
lib/libcamera.so
lib/libseccameraadaptor.so
lib/libseccamera.so

lib/libnetutils.so

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
    vendor/samsung/__DEVICE__/proprietary/lib/libgps.so:obj/lib/libgps.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsecgps.so:obj/lib/libsecgps.so

#GPS
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/lib/libgps.so:system/lib/libgps.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsecgps.so:system/lib/libsecgps.so \\

#
# Wifi
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/etc/wifi/nvram_net.txt:system/etc/wifi/nvram_net.txt \\
    vendor/samsung/__DEVICE__/proprietary/etc/wifi/nvram_mfg.txt:system/etc/wifi/nvram_mfg.txt \\
    vendor/samsung/__DEVICE__/proprietary/etc/wifi/bcm4329_aps.bin:system/etc/wifi/bcm4329_aps.bin \\
    vendor/samsung/__DEVICE__/proprietary/etc/wifi/bcm4329_mfg.bin:system/etc/wifi/bcm4329_mfg.bin \\
    vendor/samsung/__DEVICE__/proprietary/etc/wifi/bcm4329_sta.bin:system/etc/wifi/bcm4329_sta.bin

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
    vendor/samsung/__DEVICE__/proprietary/bin/sensorstatutil_yamaha:system/bin/sensorstatutil_yamaha

#
# Camera
#
#PRODUCT_COPY_FILES += \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libarccamera.so:system/lib/libarccamera.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libcamerafirmwarejni.so:system/lib/libcamerafirmwarejni.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libseccameraadaptor.so:system/lib/libseccameraadaptor.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libseccamera.so:system/lib/libseccamera.so \\
#    vendor/samsung/__DEVICE__/proprietary/cameradata/datapattern_420sp.yuv:system/cameradata/datapattern_420sp.yuv \\
#    vendor/samsung/__DEVICE__/proprietary/cameradata/datapattern_front_420sp.yuv:system/cameradata/datapattern_front_420sp.yuv \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libcamera.so:system/lib/libcamera.so

# Firmware files
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/seh/CE147F00.bin:system/vendor/firmware/CE147F00.bin \\
    vendor/samsung/__DEVICE__/proprietary/seh/CE147F01.bin:system/vendor/firmware/CE147F01.bin \\
    vendor/samsung/__DEVICE__/proprietary/seh/CE147F02.bin:system/vendor/firmware/CE147F02.bin \\
    vendor/samsung/__DEVICE__/proprietary/seh/CE147F03.bin:system/vendor/firmware/CE147F03.bin

#
# RIL
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsec-ril40.so:system/lib/libsec-ril40.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsecril-client.so:system/lib/libsecril-client.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libril.so:system/lib/libril.so

#
# OMX
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/lib/libQmageDecoder.so:system/lib/libQmageDecoder.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libquramgifmovie.so:system/lib/libquramgifmovie.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libquramimagecodec.so:system/lib/libquramimagecodec.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libquramvdecoder.so:system/lib/libquramvdecoder.so
#    vendor/samsung/__DEVICE__/proprietary/lib/libs263domxoc.so:system/lib/libs263domxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libs263eomxoc.so:system/lib/libs263eomxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libs264domxoc.so:system/lib/libs264domxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libs264eomxoc.so:system/lib/libs264eomxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsaacdomxoc.so:system/lib/libsaacdomxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsaaceomxoc.so:system/lib/libsaaceomxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsac3domxoc.so:system/lib/libsac3domxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsamrdomxoc.so:system/lib/libsamrdomxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsamreomxoc.so:system/lib/libsamreomxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsdiv3domxoc.so:system/lib/libsdiv3domxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsflacdomxoc.so:system/lib/libsflacdomxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsmp3domxoc.so:system/lib/libsmp3domxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsmp4fmocn.so:system/lib/libsmp4fmocn.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsmp4vdomxoc.so:system/lib/libsmp4vdomxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsmp4veomxoc.so:system/lib/libsmp4veomxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsvc1domxoc.so:system/lib/libsvc1domxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libswmadomxoc.so:system/lib/libswmadomxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libswmv7domxoc.so:system/lib/libswmv7domxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libswmv8domxoc.so:system/lib/libswmv8domxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libomx_evrcdec_sharedlibrary.so:system/lib/libomx_evrcdec_sharedlibrary.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libomx_evrcenc_sharedlibrary.so:system/lib/libomx_evrcenc_sharedlibrary.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libomx_qcelpdec_sharedlibrary.so:system/lib/libomx_qcelpdec_sharedlibrary.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libomx_qcelpenc_sharedlibrary.so:system/lib/libomx_qcelpenc_sharedlibrary.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libomadrm.so:system/lib/libomadrm.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libomx_avcenc_sharedlibrary.so:system/lib/libomx_avcenc_sharedlibrary.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libomx_m4venc_sharedlibrary.so:system/lib/libomx_m4venc_sharedlibrary.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libopencore_2way.so:system/lib/libopencore_2way.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsavidocn.so:system/lib/libsavidocn.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsavidreg.so:system/lib/libsavidreg.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsavsac.so:system/lib/libsavsac.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsavscmn.so:system/lib/libsavscmn.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsavsff.so:system/lib/libsavsff.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsavsvc.so:system/lib/libsavsvc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsflacfdocn.so:system/lib/libsflacfdocn.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsflacfdreg.so:system/lib/libsflacfdreg.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsflvdocn.so:system/lib/libsflvdocn.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsflvdreg.so:system/lib/libsflvdreg.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsmkvdocn.so:system/lib/libsmkvdocn.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsmkvdreg.so:system/lib/libsmkvdreg.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libswmfdocn.so:system/lib/libswmfdocn.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libswmfdreg.so:system/lib/libswmfdreg.so

#
# Other stuff
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/bin/BCM4329B1_002.002.023.0417.0430.hcd:system/bin/BCM4329B1_002.002.023.0417.0430.hcd \\
    vendor/samsung/__DEVICE__/proprietary/bin/logwrapper:system/bin/logwrapper \\
    vendor/samsung/__DEVICE__/proprietary/bin/killmediaserver:system/bin/killmediaserver \\
    vendor/samsung/__DEVICE__/proprietary/bin/netcfg:system/bin/netcfg \\
    vendor/samsung/__DEVICE__/proprietary/lib/libnetutils.so:system/lib/libnetutils.so

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
