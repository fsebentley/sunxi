Scripts for Linux

Push files to /usr/bin, chmod 777 and login-logout. You'll be able to use scripts from ANY place. 

### a10_batinfo $1

Check battery states - health, percentage, voltage etc. You can use $1 to set refresh delay (e.g. a10_batinfo 35)

### a10_batbench

Benchmark of battery - run when you have 100%, unconnect power adaptor and wait till device die. All important data are logged.

### a10_oc_auto min_khz max_khz governor

Preferred if you want to OC on autostart. Script will make what it has to do, and exit.

### a10_oc_man min_khz max_khz governor

Preferred for manual OC. Script is an infinity loop - executing at autostart will cause bootloop!

If $1 or $2 or $3 are empty, will be printed list of governors and frequencies.
