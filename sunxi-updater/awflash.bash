#!/bin/bash
#Please read readme.md to know more about making flashable cards

FLASHPATH="/FirmwareUpdate"
clear
NEWL="printf \n"
cd $FLASHPATH

#splash rominfo
printf "sunxi updater by ciddaemon\nv1.0.0b1 2013-06-08\nall rights reserved\n\n"

#check if root
printf "checking if root... "
if [ $USER != root ]
then
  printf "critical err: not root!\nis sdcard properly created???"
	exit 1
else
	printf "yes\n"
fi

#counting files
printf "counting files... "
DISKDUMP_C=`ls -1 -F *.img | grep / -v | wc -l`
ARCHIVES_C=`ls -1 -F *.t?z | grep / -v | wc -l`
CONFIG_C=`ls -1 -F *.cfg | grep / -v | wc -l`
printf "done\n$ARCHIVES_C archives, $DISKDUMP_C disk images, $CONFIG_C config files"
$NEWL

#md5
printf "checking md5sums... "
if [ ! -f checksum.cfg ]
then
	printf "critical err: md5sums file not found!\nwill continue, but only u r responsible by damages!"
else
	md5sum -c checksum.cfg
fi
$NEWL

#its the final countdownnnnnnn
printf "starting flashing in 10 seconds, please wait...\n"
sleep 10

#flashing, most important
cd /dev

printf "flashing device ...\n"
for NANDPART in `ls nand?`
do
	if [ -f $FLASHPATH/$NANDPART.t?z ]
	then
		printf "\n$NANDPART [unpacking]..."
		mkdir $FLASHPATH/tmp_$NANDPART
		mount -t ext4 $NANDPART $FLASHPATH/tmp_$NANDPART
		tar xzf $FLASHPATH/$NANDPART.t?z -C $FLASHPATH/tmp_$NANDPART
		$NEWL
	else
		if [ -f $FLASHPATH/$NANDPART.img ]
		then
			printf "\n$NANDPART [diskdumping]..."
			dd if=$FLASHPATH/$NANDPART.img of=/dev/$NANDPART
		else
			if [ ! -f $FLASHPATH/$NANDPART.* ]
			then
				printf "\n$NANDPART err: file not found...."
				$NEWL
			else
				printf "\n$NANDPART err: bad file?...."
				$NEWL
			fi
		fi
	fi
done
umount $FLASHPATH/tmp_nand*
rm -rf $FLASHPATH/tmp_nand*

#reboot after flash
printf "\nflashing done!\nplease remove sd card from device and press ENTER to reboot"
read
reboot
