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

echo --- Done

pause

echo on
