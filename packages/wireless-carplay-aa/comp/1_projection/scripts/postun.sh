#!/system/bin/sh
export PATH=/data/nemesis/bin:/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin
. ./scripts/common.sh

log "postuninstall wireless.projection"
if ! restore_all; then
    log "keeping $BACKUP_DIR"
    exit 0
fi
remove_backup_dir || exit 1
log "removed $BACKUP_DIR"
sync
exit 0
