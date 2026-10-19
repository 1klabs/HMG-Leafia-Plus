#!/system/bin/sh
. ./scripts/common.sh
log "preuninstall wireless.carplay.aa"
check_addons || exit 1
uninstall_parts "$PARTS_REV" || exit 1
sync
log "all parts back to stock - reboot the head unit to finish"
exit 0
