# sunxi updater

Tool for updating partitions content on Allwinner A10 boards. It boots from SD card automagically, flashes partitions and reboots - no interaction with user. **Yet**.

## Preparing SD card

* After preparing bootable SD card with minimal Linux (eg. Linaro nano), make directory /FirmwareUpdate. **Do not use other names!**
* cd there and copy awflash.bash to it.
* Make file executable via command `chmod +x awflash.bash`
* Prepare tarballs (gz or xz compressed) or IMG files (diskdumps). Use **tarballs rather than IMGs** (of cource, raw data like kernel or environment must be diskdumped). You **must** use .tgz and .txz extensions!!! .tar.gz and .tar.xz are **not supported** yet.
* Change the names of files to **match the names of the partition**, for example nanda.txz - /dev/nanda
* Copy files to /FirmwareUpdate directory
* Generate md5sum of files via `md5sum * > checksum.cfg` (**remove** checksum.cfg if you want to check md5s again!)
* Set script to run on autostart, after logging in.
* Set autologin to **root** user (Linaro tarballs have this out of the box)
* Done. Reboot and check if SD card works properly :)
