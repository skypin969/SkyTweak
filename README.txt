SKYTWEAK v9.6.9
Author: Skypin969 (Telegram: @Skypin969)
For: KernelSU Next
Profile: balanced (seimbang)


WHAT IT DOES
------------
This module applies several kernel and Android tweaks every time the phone boots.
Memory values are taken from the balance profile of KTweak.

1. Memory
   Controls how often the system moves data to swap, and when dirty memory
   is written to storage.

2. Storage
   Raises the maximum size of one read/write request to the main disk, from
   512 KB to 768 KB (default on the test device).

3. Network
   TCP connections no longer restart from slow start after a short idle
   period. Helpful when browsing, where traffic starts and stops often.

4. Foreground apps
   Raises the minimum CPU boost for the app in the foreground (uclamp top-app)
   from 12.5 percent to 15 percent.


WHAT IT DOES NOT CHANGE
-----------------------
- CPU governor and CPU scheduler stay at their defaults.
- TCP buffer sizes stay at their defaults.
- No battery-saving feature is included. That is in the SAVER BY SKYPIN
  module. The two modules are not related and work independently.


INSTALLATION
------------
1. In KernelSU Next, open Modules, then Install from storage.
2. Select the file SkyTweak-v9.6.9.zip.
3. Wait until it finishes, then restart the phone.


CHANGING SETTINGS
-----------------
1. Open the file /data/adb/skytweak/config.txt. You need a file manager with
   root access, or Termux with su.
2. Edit the values. The format is key=value with no spaces. Lines starting
   with # are ignored.
3. Save, then restart the phone.

The config is kept when the module is updated, so your changes are not lost.


READING THE LOG
---------------
Open /data/adb/skytweak/log.txt. Each line has one of these statuses (the
log text itself is in Indonesian):
- OK: the setting was written. The value read back afterwards is also logged.
- LEWAT (skipped): the setting does not exist on this phone, so it was skipped.
- GAGAL (failed): the system rejected the value.
The previous boot's log is kept in log.txt.old.


UNINSTALLING AND TURNING OFF
----------------------------
- Temporarily: disable the module in KernelSU Next, then restart the phone.
- Remove: remove the module in KernelSU Next, then restart the phone. The
  folder /data/adb/skytweak (config and log) is deleted too.


NOTES
-----
- Values are not saved permanently. On every boot, the module applies them again.
- Android may change some values while the phone is in use. This is not a
  module error. Check the log to see the values actually read.
- This module cannot fix download speed drops caused by signal or network
  conditions.
- Before using it more widely, test it on your own device and check the log
  after a restart.
