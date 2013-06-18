#!/bin/bash


if [ -z $1 ]
then
	echo "Please insert FULL path to ADB binary as a parameter, for example /home/matthew/sdk/platform-tools/adb"
	exit 1
fi

echo "Connect device, check if u have drivers and enabled debugging"
read

$1 shell mv /data/local/tmp /data/local/tmp.bak
$1 shell ln -s /data /data/local/tmp
$1 reboot
echo "Reboot 1/3 - Press ENTER after full reboot"
read

$1 shell rm /data/local.prop > nul
$1 shell "echo \"ro.kernel.qemu=1\" > /data/local.prop"
$1 reboot
echo "Reboot 2/3 - Press ENTER afer full reboot"
read

$1 shell id
echo "If ID equals 0/root, continue. In another case kill script and try again."
read

$1 remount
$1 push su /system/bin/su
$1 shell chown root.shell /system/bin/su
$1 shell chmod 6755 /system/bin/su
$1 push su /system/xbin/su
$1 shell chown root.shell /system/xbin/su
$1 shell chmod 6755 /system/xbin/su
$1 push busybox /system/bin/busybox
$1 shell chown root.shell /system/bin/busybox
$1 shell chmod 0755 /system/bin/busybox
$1 push Superuser.apk /system/app/Superuser.apk
$1 shell chown root.root /system/app/Superuser.apk
$1 shell chmod 0644 /system/app/Superuser.apk
$1 shell rm /data/local.prop
$1 shell rm /data/local/tmp
$1 shell mv /data/local/tmp.bak /data/local/tmp
$1 reboot

echo "Done."
echo ""
echo "PATCHES FOR ROMS WITH DATA_PART BACKUP"
echo "On some ROMs there is hidden backup,"
echo "if you want to remove it press ENTER,"
echo "if not press CTRL+C"
echo "if not sure, press ENTER, it will not hurt, heh"
read

$1 shell mkdir /mnt/nandi
$1 shell mount -t ext4 /dev/block/nandi /mnt/nandi
$1 shell cd /mnt/nandi
$1 shell rm -r *.gz*
$1 reboot

echo ""
echo "BUILD.PROP WITH GOOD DPI AND UNLOCKED GPLAY"
echo "If you have too big elements,"
echo "or apps in Google Play are not available,"
echo "press ENTER, it will not hurt."
echo "If everything good, press CTR+C"
read

$1 push system/build.prop /system
$1 push system/etc/permissions/android.hardware.camera.autofocus.xml /system/etc/permissions/android.hardware.camera.autofocus.xml
$1 push system/etc/permissions/android.hardware.camera.flash-autofocus.xml /system/etc/permissions/android.hardware.camera.flash-autofocus.xml
$1 push system/etc/permissions/android.hardware.camera.front.xml /system/etc/permissions/android.hardware.camera.front.xml
$1 push system/etc/permissions/android.hardware.camera.xml /system/etc/permissions/android.hardware.camera.xml
$1 push system/etc/permissions/android.hardware.location.gps.xml /system/etc/permissions/android.hardware.location.gps.xml
$1 push system/etc/permissions/android.hardware.location.xml /system/etc/permissions/android.hardware.location.xml
$1 push system/etc/permissions/android.hardware.sensor.accelerometer.xml /system/etc/permissions/android.hardware.sensor.accelerometer.xml
$1 push system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml /system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml
$1 push system/etc/permissions/android.hardware.touchscreen.xml /system/etc/permissions/android.hardware.touchscreen.xml
$1 push system/etc/permissions/android.hardware.usb.accessory.xml /system/etc/permissions/android.hardware.usb.accessory.xml
$1 push system/etc/permissions/android.software.live_wallpaper.xml /system/etc/permissions/android.software.live_wallpaper.xml
$1 push system/etc/permissions/com.android.location.provider.xml /system/etc/permissions/com.android.location.provider.xml
$1 push system/etc/permissions/platform.xml /system/etc/permissions/platform.xml
$1 push system/etc/permissions/tablet_core_hardware.xml /system/etc/permissions/tablet_core_hardware.xml
$1 shell chmod 0644 /system/etc/permissions/android.hardware.camera.autofocus.xml
$1 shell chmod 0644 /system/etc/permissions/android.hardware.camera.flash-autofocus.xml
$1 shell chmod 0644 /system/etc/permissions/android.hardware.camera.front.xml
$1 shell chmod 0644 /system/etc/permissions/android.hardware.camera.xml
$1 shell chmod 0644 /system/etc/permissions/android.hardware.location.gps.xml
$1 shell chmod 0644 /system/etc/permissions/android.hardware.location.xml
$1 shell chmod 0644 /system/etc/permissions/android.hardware.sensor.accelerometer.xml
$1 shell chmod 0644 /system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml
$1 shell chmod 0644 /system/etc/permissions/android.hardware.touchscreen.xml
$1 shell chmod 0644 /system/etc/permissions/android.hardware.usb.accessory.xml
$1 shell chmod 0644 /system/etc/permissions/android.software.live_wallpaper.xml
$1 shell chmod 0644 /system/etc/permissions/com.android.location.provider.xml
$1 shell chmod 0644 /system/etc/permissions/platform.xml
$1 shell chmod 0644 /system/etc/permissions/tablet_core_hardware.xml
$1 shell chmod 0644 /system/build.prop
$1 shell reboot

echo "All possible things done."
echo "Press ENTER to finish"
read

exit 0
