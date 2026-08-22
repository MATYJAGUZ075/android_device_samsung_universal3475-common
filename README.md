# universal3475-common — LineageOS 20 (Android 13)

Árbol común SoC para Exynos3475 (j2lte / j1xlte / on5ltetmo). Este porte
solo trabaja activamente sobre **j2lte**.

**Estado: FASE 0 (skeleton).** Ver README de `device/samsung/j2lte` y los
documentos `ANALISIS_*.md` en la raíz del proyecto.

## Contenido

| Ruta | Estado |
|---|---|
| `BoardConfigCommon.mk` | Reescrito formato LOS20 (clang kernel, VINTF, sepolicy vendor, wifi HIDL) |
| `device-common.mk` | Reescrito: paquetes T, sin configstore/renderscript/textclassifier |
| `system.prop` | Nuevo (antes system_prop.mk) |
| `compatibility_matrix.xml` | Nuevo (DEVICE_MATRIX_FILE) |
| `configs/cgroups.json` + `task_profiles.json` | Nuevos, requeridos por init de A13 en kernels legacy |
| `ramdisk/etc/fstab.universal3475` | Cifrado eliminado + zram añadido |
| `sepolicy/vendor/` | Reglas 17.1 migradas; neverallows pendientes (ver sepolicy/README.md) |
| `camera/`, `hardware/bluetooth/`, `libshims/`, `libsecnativefeature/` | Código 17.1 intacto — se adapta en fases 3-6 |

## Dependencias externas

Los repos SLSI de LineageOS (`exynos`, `exynos5`, `openmax`) llegan como
máximo a `lineage-19.1`: harán falta forks actualizados a T. Marcados como
`optional` en `lineage.dependencies`.
