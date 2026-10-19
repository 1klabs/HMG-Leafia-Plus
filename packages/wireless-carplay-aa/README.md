# Wireless CarPlay/AA package (`wireless.carplay.aa`)

NEMESIS package source. It installs four parts in order, with one reboot at the end:

| Part | Folder | What it changes |
|---|---|---|
| Wireless projection | `comp/1_projection` | Wireless feature flags, region folder from `ro.mobis.targetdir` (hotspot only) |
| Turn-by-turn | `comp/2_tbt` | Projection apps (NEMESIS community package). Refuses unless the firmware has every cluster call it uses. |
| CarPlay bridge | `comp/3_bridge` | Projection apps + `libCarPlayCore` via lpatch (`carplay-core-wifi`) |
| CarPlay audio | `comp/4_audio` | `libCarPlayAudio` / `libCarPlayUtils` via lpatch, plus `libev6aac.so` where needed |

Native libraries are patched on the head unit with `lpatch` and the recipes in `/recipes`. No modified system library is shipped.

## App payloads are not in this repository

`comp/2_tbt/files*` and `comp/3_bridge/files*` hold the projection app builds (`HKMC_DiPO`, `HKMC_GPM`, `HKMC_Navi_ExSL`, `Iap2ServerApp`, `libautoreceiver_infobank.so`). They are modified copies of manufacturer apps, so they are kept out of this repository.

- **Where they come from:** the turn-by-turn builds come from the NEMESIS community package. The bridge builds are those plus the HMG Leafia Plus bridge code.
- **Per-car folders:** `files_neev` holds the Ioniq 5 builds. They are the same code placed into that car's own app files.

To build the installable zip, point the build script at a folder that has the same layout:

```
tools/build-package.sh /path/to/payloads
```

`/path/to/payloads` must contain `2_tbt/files`, `2_tbt/files_neev`, `3_bridge/files` and `3_bridge/files_neev`.
