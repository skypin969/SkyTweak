# SkyTweak

A KernelSU Next module that applies a set of kernel and Android tweaks every time the phone boots.

- **Version:** v9.6.9
- **Profile:** balanced (seimbang)
- **Author:** Skypin969 (Telegram: @Skypin969)
- **License:** MIT, see [LICENSE](LICENSE)

Memory values are taken from the balance profile of KTweak.

## What it changes

1. **Memory:** controls how often the system moves data to swap, and when dirty memory is written to storage.
2. **Storage:** raises the maximum size of one read/write request to the main disk, from 512 KB to 768 KB (default on the test device).
3. **Network:** TCP connections no longer restart from slow start after a short idle period. Helpful when browsing, where traffic starts and stops often.
4. **Foreground apps:** raises the minimum CPU boost for the app in the foreground (uclamp top-app) from 12.5 percent to 15 percent.

## What it does not change

- CPU governor and CPU scheduler stay at their defaults.
- TCP buffer sizes stay at their defaults.
- No battery-saving feature is included. That is in the SAVER BY SKYPIN module, and the two modules work independently.

## Installation

1. Prepare a module zip with the files at the **root** of the zip: `module.prop`, `customize.sh`, `service.sh`, `uninstall.sh`, `config.txt`, `README.txt`, and `LICENSE`.
2. In KernelSU Next, open **Modules > Install from storage** and select that zip.
3. Wait until it finishes, then restart the phone.

> Do not install directly from GitHub's "Download ZIP". That zip wraps all files in a single folder, so KernelSU will not find `module.prop` at the root.

## Changing settings

1. Open `/data/adb/skytweak/config.txt`. You need a file manager with root access, or Termux with `su`.
2. Edit the values. The format is `key=value` with no spaces. Lines starting with `#` are ignored.
3. Save, then restart the phone.

The config is kept when the module is updated, so your changes are not lost.

## Reading the log

Open `/data/adb/skytweak/log.txt`. Each line has one of these statuses (the log text itself is in Indonesian):

- **OK:** the setting was written. The value read back afterwards is also logged.
- **LEWAT** (skipped): the setting does not exist on this phone, so it was skipped.
- **GAGAL** (failed): the system rejected the value.

The previous boot's log is kept in `log.txt.old`.

## Uninstalling and turning off

- **Temporarily:** disable the module in KernelSU Next, then restart the phone.
- **Remove:** remove the module in KernelSU Next, then restart the phone. The folder `/data/adb/skytweak` (config and log) is deleted too.

## Notes

- Values are not saved permanently. On every boot, the module applies them again.
- Android may change some values while the phone is in use. Check the log to see the values actually read.
- This module cannot fix download speed drops caused by signal or network conditions.
- Before using it more widely, test it on your own device and check the log after a restart.
