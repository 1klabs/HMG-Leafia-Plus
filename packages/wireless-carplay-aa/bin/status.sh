#!/system/bin/sh
cd /data/nemesis/apps/wireless.carplay.aa 2>/dev/null || cd "${0%/*}/.." 2>/dev/null || true
. ./scripts/common.sh
for _p in $PARTS; do
    echo "== $(part_name $_p)"
    ( cd "comp/$_p" && /system/bin/sh bin/status.sh ) 2>&1
done
exit 0
