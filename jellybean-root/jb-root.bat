echo off

cls


echo.

echo --- Connect device, check if u have drivers and enabled debugging

pause



adb shell mv /data/local/tmp /data/local/tmp.bak

adb shell ln -s /data /data/local/tmp
adb reboot
echo --- Reboot 1/3 - Press ENTER after full reboot
pause

adb shell rm /data/local.prop > nul
adb shell "echo \"ro.kernel.qemu=1\" > /data/local.prop"
adb reboot
echo --- Reboot 2/3 - Press ENTER afer full reboot
pause

adb shell id
echo --- If ID equals 0/root, continue. In another case kill script and try again.

pause

adb remount
adb push su /system/bin/su
adb shell chown root.shell /system/bin/su
adb shell chmod 6755 /system/bin/su
adb push su /system/xbin/su
adb shell chown root.shell /system/xbin/su
adb shell chmod 6755 /system/xbin/su
adb push busybox /system/bin/busybox
adb shell chown root.shell /system/bin/busybox
adb shell chmod 0755 /system/bin/busybox
adb push Superuser.apk /system/app/Superuser.apk
adb shell chown root.root /system/app/Superuser.apk
adb shell chmod 0644 /system/app/Superuser.apk
adb shell rm /data/local.prop
adb shell rm /data/local/tmp
adb shell mv /data/local/tmp.bak /data/local/tmp
adb reboot

echo --- Done.
echo.
echo --- PATCHES FOR ROMS WITH DATA_PART BACKUP
echo --- On some ROMs there is hidden backup,
echo --- if you want to remove it press ENTER,
echo --- if not press CTRL+C
echo --- if not sure, press ENTER, it will not hurt, heh

pause

adb shell mkdir /mnt/nandi
adb shell mount -t ext4 /dev/block/nandi /mnt/nandi
adb shell cd /mnt/nandi
adb shell rm -r *.gz*
adb shell reboot

echo.
echo --- BUILD.PROP WITH GOOD DPI AND UNLOCKED GPLAY
echo --- If you have too big elements,
echo --- or apps in Google Play are not available,
echo --- press ENTER, it will not hurt.
echo --- If everything good, press CTR+C
pause

adb push system/build.prop /system
adb push system/etc/permissions/android.hardware.camera.autofocus.xml /system/etc/permissions/android.hardware.camera.autofocus.xml
adb push system/etc/permissions/android.hardware.camera.flash-autofocus.xml /system/etc/permissions/android.hardware.camera.flash-autofocus.xml
adb push system/etc/permissions/android.hardware.camera.front.xml /system/etc/permissions/android.hardware.camera.front.xml
adb push system/etc/permissions/android.hardware.camera.xml /system/etc/permissions/android.hardware.camera.xml
adb push system/etc/permissions/android.hardware.location.gps.xml /system/etc/permissions/android.hardware.location.gps.xml
adb push system/etc/permissions/android.hardware.location.xml /system/etc/permissions/android.hardware.location.xml
adb push system/etc/permissions/android.hardware.sensor.accelerometer.xml /system/etc/permissions/android.hardware.sensor.accelerometer.xml
adb push system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml /system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml
adb push system/etc/permissions/android.hardware.touchscreen.xml /system/etc/permissions/android.hardware.touchscreen.xml
adb push system/etc/permissions/android.hardware.usb.accessory.xml /system/etc/permissions/android.hardware.usb.accessory.xml
adb push system/etc/permissions/android.software.live_wallpaper.xml /system/etc/permissions/android.software.live_wallpaper.xml
adb push system/etc/permissions/com.android.location.provider.xml /system/etc/permissions/com.android.location.provider.xml
adb push system/etc/permissions/platform.xml /system/etc/permissions/platform.xml
adb push /system/etc/permissions/tablet_core_hardware.xml /system/etc/permissions/tablet_core_hardware.xml
adb shell chmod 0644 /system/etc/permissions/android.hardware.camera.autofocus.xml
adb shell chmod 0644 /system/etc/permissions/android.hardware.camera.flash-autofocus.xml
adb shell chmod 0644 /system/etc/permissions/android.hardware.camera.front.xml
adb shell chmod 0644 /system/etc/permissions/android.hardware.camera.xml
adb shell chmod 0644 /system/etc/permissions/android.hardware.location.gps.xml
adb shell chmod 0644 /system/etc/permissions/android.hardware.location.xml
adb shell chmod 0644 /system/etc/permissions/android.hardware.sensor.accelerometer.xml
adb shell chmod 0644 /system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml
adb shell chmod 0644 /system/etc/permissions/android.hardware.touchscreen.xml
adb shell chmod 0644 /system/etc/permissions/android.hardware.usb.accessory.xml
adb shell chmod 0644 /system/etc/permissions/android.software.live_wallpaper.xml
adb shell chmod 0644 system/etc/permissions/com.android.location.provider.xml
adb shell chmod 0644 system/etc/permissions/platform.xml
adb shell chmod 0644 system/etc/permissions/tablet_core_hardware.xml
adb shell chmod 0644 system/build.prop
reboot

echo --- All possible things done.
echo --- Press ENTER to finish

pause
echo on
