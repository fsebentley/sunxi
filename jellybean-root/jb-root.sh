#!/bin/sh


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
echo "Done"
read

exit 0
