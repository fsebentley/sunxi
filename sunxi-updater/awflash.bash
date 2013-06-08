#!/bin/bash
#Please read readme.md to know more about making flashable cards

FLASHPATH="/FirmwareUpdate"
clear
NEWL="printf \n"
cd $FLASHPATH

#splash rominfo
printf "sunxi Updater by CidDaemon\nv1.0.0b1 2013-06-08\nScript comes with ABSOLUTELY NO WARRANTY. Author is not responsible by any damages caused by uncorrect usage of script.\n\n"

#check if root
printf "[ ] Checking if root... "
if [ $USER != root ]
then
  printf "Error: not root!\nIs SD card properly created???"
	exit 1
else
	printf "yes\n"
fi

#counting files
printf "[ ] Counting files... "
DISKDUMP_C=`ls -1 -F *.img | grep / -v | wc -l`
ARCHIVES_C=`ls -1 -F *.t?z | grep / -v | wc -l`
CONFIG_C=`ls -1 -F *.cfg | grep / -v | wc -l`
printf "done\n$ARCHIVES_C archives, $DISKDUMP_C disk images, $CONFIG_C config files"
$NEWL

#md5
printf "[ ] Checking md5sums... "
if [ ! -f checksum.cfg ]
then
	printf "Error: file with md5sums not found!\nScript will continue, but only YOU are responsible by possible damages!"
else
	md5sum -c checksum.cfg
fi
$NEWL

#its the final countdownnnnnnn
printf "[!] Starting flashing in 10 seconds, please wait...\n"
sleep 10

#flashing, most important
cd /dev

printf "[ ] Flashing device ...\n"
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
				printf "\n$NANDPART Error: file not found"
				$NEWL
			else
				printf "\n$NANDPART Error: bad file?"
				$NEWL
			fi
		fi
	fi
done
umount $FLASHPATH/tmp_nand*
rm -rf $FLASHPATH/tmp_nand*

#reboot after flash
printf "\n[*] Flashing done!\nPlease remove SD card from device and then press ENTER to reboot"
read
reboot
