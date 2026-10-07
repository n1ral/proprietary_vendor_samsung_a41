#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/platform/bootdevice/by-name/recovery$(getprop ro.boot.slot_suffix):33554432:ae20409e40ace06cf27f310f77f536da99ffa725; then
  applypatch \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/platform/bootdevice/by-name/boot$(getprop ro.boot.slot_suffix):33554432:292eb51d6fdc4310ca889b4a4ece526328cdfc20 \
          --target EMMC:/dev/block/platform/bootdevice/by-name/recovery$(getprop ro.boot.slot_suffix):33554432:ae20409e40ace06cf27f310f77f536da99ffa725 && \
      (log -t install_recovery "Installing new recovery image: succeeded" && setprop vendor.ota.recovery.status 200) || \
      (log -t install_recovery "Installing new recovery image: failed" && setprop vendor.ota.recovery.status 454)
else
  log -t install_recovery "Recovery image already installed" && setprop vendor.ota.recovery.status 200
fi

