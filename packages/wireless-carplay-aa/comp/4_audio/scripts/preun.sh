#!/system/bin/sh
. ./scripts/common.sh
log "preuninstall carplay.wifi.audio (aac)"
if ! restore_all; then
    log "keeping $BACKUP_DIR"
    exit 1
fi
remove_backup_dir || exit 1
log "stock libraries back - reboot the HU to finish"
exit 0
