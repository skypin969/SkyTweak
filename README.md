# SkyTweak

Modul KernelSU Next untuk menerapkan beberapa pengaturan kernel dan Android setiap HP menyala.

- **Versi:** v9.6.9
- **Profil:** seimbang
- **Author:** Skypin969 (Telegram: @Skypin969)
- **Lisensi:** MIT, lihat [LICENSE](LICENSE)

Nilai memori diambil dari profil balance KTweak.

## Isi modul

1. **Memori:** mengatur seberapa sering sistem memindahkan data ke swap, dan kapan data di memori ditulis ke penyimpanan.
2. **Penyimpanan:** menaikkan batas ukuran satu permintaan baca/tulis ke disk utama, dari 512 KB menjadi 768 KB (nilai bawaan HP uji).
3. **Jaringan:** koneksi TCP tidak lagi "mulai pelan dari nol" setiap kali sempat diam. Berguna saat berselancar yang sering berhenti lalu lanjut lagi.
4. **Aplikasi di layar depan:** menaikkan batas bawah tenaga CPU untuk aplikasi yang sedang dibuka (uclamp top-app) dari 12,5 persen menjadi 15 persen.

## Yang tidak diubah

- Governor dan penjadwal CPU tetap bawaan.
- Buffer TCP tetap bawaan.
- Tidak ada fitur hemat baterai. Fitur itu ada di modul SAVER BY SKYPIN, dan kedua modul bekerja masing-masing.

## Cara pasang

1. Siapkan zip modul yang berisi file-file di **dalam root** zip, yaitu `module.prop`, `customize.sh`, `service.sh`, `uninstall.sh`, `config.txt`, `README.txt`, dan `LICENSE`.
2. Di KernelSU Next, buka **Modules > Install from storage**, lalu pilih zip tersebut.
3. Tunggu sampai selesai, lalu restart HP.

> Jangan memasang langsung dari "Download ZIP" di GitHub. Zip dari GitHub membungkus semua file dalam satu folder, sehingga KernelSU tidak menemukan `module.prop` di root.

## Cara mengubah pengaturan

1. Buka `/data/adb/skytweak/config.txt`. Perlu aplikasi file manager dengan akses root, atau Termux dengan su.
2. Ubah nilainya. Formatnya `kunci=nilai`, tanpa spasi. Baris yang diawali `#` diabaikan.
3. Simpan, lalu restart HP.

Config tetap dipakai saat modul diperbarui, jadi perubahan Anda tidak hilang.

## Cara melihat log

Buka `/data/adb/skytweak/log.txt`. Setiap baris berisi salah satu status berikut:

- **OK:** pengaturan berhasil ditulis, beserta nilai yang terbaca setelahnya.
- **LEWAT:** pengaturan tidak ada di HP ini, sehingga dilewati.
- **GAGAL:** sistem menolak nilai tersebut.

Log boot sebelumnya disimpan di `log.txt.old`.

## Cara membatalkan

- **Sementara:** matikan modul di KernelSU Next, lalu restart HP.
- **Hapus:** hapus modul di KernelSU Next, lalu restart HP. Folder `/data/adb/skytweak` (config dan log) ikut terhapus.

## Catatan

- Nilai tidak disimpan permanen. Setiap boot, modul menerapkannya lagi.
- Sebagian nilai bisa diubah Android saat HP dipakai. Cek log untuk melihat nilai yang sebenarnya terbaca.
- Modul ini tidak memperbaiki kecepatan unduh yang turun karena sinyal atau kondisi jaringan.
- Sebelum dipakai lebih luas, uji dulu di perangkat Anda dan periksa log setelah restart.
