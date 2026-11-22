#!/system/bin/sh
# SkyTweak - service.sh
# Dijalankan otomatis setiap HP menyala, setelah Android selesai boot.
# Membaca /data/adb/skytweak/config.txt lalu menulis nilainya ke sistem.

MODDIR=/data/adb/modules/skytweak
DATADIR=/data/adb/skytweak
CONFIG="$DATADIR/config.txt"
LOG="$DATADIR/log.txt"

# Karakter tab dan enter Windows, dipakai untuk membersihkan config
TAB="$(printf '\t')"
CR="$(printf '\r')"

# Catat satu baris ke log, lengkap dengan waktu
log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG"
}

# Tulis satu nilai ke satu file sistem, lalu baca lagi untuk dicatat
apply() {
  path="$1"
  value="$2"

  # Lewati jika file tidak ada di HP ini
  if [ ! -e "$path" ]; then
    log "LEWAT  $path (tidak ada di perangkat ini)"
    return 1
  fi

  chmod +w "$path" 2>/dev/null
  if echo "$value" 2>/dev/null > "$path"; then
    now="$(cat "$path" 2>/dev/null)"
    log "OK     $path = $now (diminta $value)"
    return 0
  fi

  log "GAGAL  $path (sistem menolak nilai $value)"
  return 1
}

# Atur batas ukuran permintaan I/O untuk disk utama (sd* dan mmcblk*)
apply_queue() {
  target="$1"

  case "$target" in
    ''|*[!0-9]*)
      log "GAGAL  queue.max_sectors_kb harus berupa angka, bukan: $target"
      return 1
      ;;
  esac

  for q in /sys/block/sd[a-z]/queue /sys/block/mmcblk[0-9]/queue; do
    [ -d "$q" ] || continue

    hw="$(cat "$q/max_hw_sectors_kb" 2>/dev/null)"
    case "$hw" in
      ''|*[!0-9]*)
        log "LEWAT  $q (max_hw_sectors_kb tidak terbaca)"
        continue
        ;;
    esac

    # Nilai baru tidak boleh melebihi batas maksimum perangkat
    if [ "$hw" -ge "$target" ]; then
      apply "$q/max_sectors_kb" "$target"
    else
      log "LEWAT  $q (batas perangkat $hw KB, lebih kecil dari $target KB)"
    fi
  done
}

# Terapkan satu pengaturan dari config, sesuai namanya
apply_setting() {
  key="$1"
  value="$2"

  case "$key" in
    vm.*|net.*)
      # Titik diganti garis miring: vm.swappiness -> /proc/sys/vm/swappiness
      apply "/proc/sys/$(echo "$key" | tr '.' '/')" "$value"
      ;;
    queue.max_sectors_kb)
      apply_queue "$value"
      ;;
    uclamp.top_app.min)
      apply "/dev/cpuctl/top-app/cpu.uclamp.min" "$value"
      ;;
    profile)
      log "PROFIL $value"
      ;;
    *)
      log "LEWAT  kunci tidak dikenal: $key"
      ;;
  esac
}

# Baca config.txt baris demi baris
read_config() {
  while IFS= read -r line || [ -n "$line" ]
  do
    # Simpan baris asli, untuk dicatat jika ada yang salah
    raw="$line"

    # Buang spasi, tab, dan enter Windows
    line="$(printf '%s' "$line" | tr -d " $TAB$CR")"

    # Lewati baris kosong dan komentar
    case "$line" in
      ''|'#'*) continue ;;
    esac

    # Baris harus berbentuk kunci=nilai
    case "$line" in
      *=*) ;;
      *)
        log "LEWAT  baris tidak valid: $raw"
        continue
        ;;
    esac

    key="${line%%=*}"
    value="${line#*=}"

    if [ -z "$value" ]; then
      log "LEWAT  $key (nilai kosong)"
      continue
    fi

    apply_setting "$key" "$value"
  done < "$CONFIG"
}

# ---- Mulai ----

mkdir -p "$DATADIR"

# Simpan log boot sebelumnya sebagai log.txt.old, lalu mulai log baru
[ -f "$LOG" ] && mv "$LOG" "$LOG.old"

# Tunggu Android selesai boot, lalu tunggu 30 detik lagi
# supaya Android selesai mengatur nilainya sendiri sebelum SkyTweak masuk
until [ "$(getprop sys.boot_completed)" = "1" ]
do
  sleep 1
done
sleep 30

VERSION="$(grep '^version=' "$MODDIR/module.prop" 2>/dev/null | cut -d= -f2)"
log "=== SkyTweak $VERSION mulai ==="

# Buat config dari contoh di modul jika belum ada
if [ ! -f "$CONFIG" ]; then
  if cp "$MODDIR/config.txt" "$CONFIG" 2>/dev/null; then
    log "config.txt belum ada, dibuat dari contoh di modul"
  else
    log "GAGAL  tidak bisa menyalin config.txt"
  fi
fi

if [ -f "$CONFIG" ]; then
  read_config
else
  log "GAGAL  config.txt tidak ditemukan, tidak ada yang diterapkan"
fi

log "=== Selesai ==="
exit 0
