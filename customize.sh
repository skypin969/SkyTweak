# SkyTweak - customize.sh
# Dijalankan saat modul dipasang lewat KernelSU Next (Install from storage).
# File ini dijalankan oleh installer, jadi jangan memakai perintah exit.

ui_print "*******************************"
ui_print "  SkyTweak v9.6.9"
ui_print "  Profil: seimbang"
ui_print "*******************************"

ui_print "- Cek perangkat"
if [ -e /dev/cpuctl/top-app/cpu.uclamp.min ]; then
  ui_print "  uclamp top-app: ada"
else
  ui_print "  uclamp top-app: tidak ada, dilewati"
fi
if [ -e /proc/sys/vm/swappiness ]; then
  ui_print "  pengaturan memori: ada"
else
  ui_print "  pengaturan memori: tidak ada, dilewati"
fi
if [ -e /proc/sys/net/ipv4/tcp_slow_start_after_idle ]; then
  ui_print "  pengaturan TCP: ada"
else
  ui_print "  pengaturan TCP: tidak ada, dilewati"
fi

ui_print "- Menyiapkan folder data"
mkdir -p /data/adb/skytweak
if [ -f /data/adb/skytweak/config.txt ]; then
  ui_print "  config.txt lama dipertahankan"
elif cp "$MODPATH/config.txt" /data/adb/skytweak/config.txt; then
  ui_print "  config.txt dibuat (profil seimbang)"
else
  ui_print "  GAGAL menyalin config.txt"
fi

ui_print "- Mengatur izin file"
chmod 0755 "$MODPATH/service.sh" "$MODPATH/uninstall.sh"

ui_print "- Selesai"
ui_print "  Restart HP untuk menerapkan."
ui_print "  Log ada di /data/adb/skytweak/log.txt"
