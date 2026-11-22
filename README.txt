SKYTWEAK v9.6.9
Author: Skypin969 (Telegram: @Skypin969)
Untuk: KernelSU Next
Profil: seimbang


APA ISINYA
----------
Modul ini menerapkan beberapa pengaturan kernel dan Android setiap HP menyala.
Nilai memori diambil dari profil balance KTweak.

1. Memori
   Mengatur seberapa sering sistem memindahkan data ke swap dan kapan data
   di memori ditulis ke penyimpanan.

2. Penyimpanan
   Menaikkan batas ukuran satu permintaan baca/tulis ke disk utama, dari
   512 KB menjadi 768 KB (nilai bawaan HP uji).

3. Jaringan
   Koneksi TCP tidak lagi "mulai pelan dari nol" setiap kali sempat diam.
   Berguna saat berselancar yang sering berhenti lalu lanjut lagi.

4. Aplikasi di layar depan
   Menaikkan batas bawah tenaga CPU untuk aplikasi yang sedang dibuka
   (uclamp top-app) dari 12,5 persen menjadi 15 persen.


YANG TIDAK DIUBAH
-----------------
- Governor dan penjadwal CPU tetap bawaan.
- Buffer TCP tetap bawaan.
- Tidak ada fitur hemat baterai. Fitur itu ada di modul SAVER BY SKYPIN.
  Kedua modul tidak saling terkait dan bekerja masing-masing.


CARA PASANG
-----------
1. Buka KernelSU Next, lalu Modules, lalu Install from storage.
2. Pilih file SkyTweak-v9.6.9.zip.
3. Tunggu sampai selesai, lalu restart HP.


CARA MENGUBAH PENGATURAN
------------------------
1. Buka file /data/adb/skytweak/config.txt. Perlu aplikasi file manager
   dengan akses root, atau Termux dengan su.
2. Ubah nilainya. Formatnya kunci=nilai, tanpa spasi. Baris yang diawali
   tanda # diabaikan.
3. Simpan, lalu restart HP.

Config tetap dipakai saat modul diperbarui, jadi perubahan Anda tidak hilang.


CARA MELIHAT LOG
----------------
Buka /data/adb/skytweak/log.txt. Setiap baris berisi salah satu status ini:
- OK: pengaturan berhasil ditulis. Nilai yang terbaca setelahnya ikut dicatat.
- LEWAT: pengaturan tidak ada di HP ini, jadi dilewati.
- GAGAL: sistem menolak nilai tersebut.
Log boot sebelumnya disimpan di log.txt.old.


CARA MEMBATALKAN
----------------
- Sementara: matikan modul di KernelSU Next, lalu restart HP.
- Hapus: hapus modul di KernelSU Next, lalu restart HP. Folder
  /data/adb/skytweak (config dan log) ikut terhapus.


CATATAN
-------
- Nilai tidak disimpan permanen. Setiap boot, modul menerapkannya lagi.
- Sebagian nilai bisa diubah Android saat HP dipakai. Itu bukan kesalahan
  modul. Cek log untuk melihat nilai yang sebenarnya terbaca.
- Modul ini tidak bisa memperbaiki kecepatan unduh yang turun karena sinyal
  atau kondisi jaringan.
- Sebelum dipakai lebih luas, uji dulu di HP Anda dan periksa log setelah
  restart.
