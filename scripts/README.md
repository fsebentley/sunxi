Scripts for Linux

Push files to /usr/bin, chmod 777 and login-logout. You'll be able to use scripts from ANY place. 

a10_oc_auto min_khz max_khz governor
------------------------------------

Preferred if you want to OC on autostart. Script will make what it has to do, and exit.

a10_oc_man min_khz max_khz governor
-----------------------------------

Preferred for manual OC. Script is an infinity loop - executing at autostart will cause bootloop!

If $1 or $2 or $3 are empty, will be printed list of governors and frequencies.