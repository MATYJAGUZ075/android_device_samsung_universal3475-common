# universal3475-common — LineageOS 20 (Android 13)

Árbol común para Exynos3475 (j2lte / j1xlte / on5ltetmo). El porte se está
trabajando principalmente sobre **j2lte**.

**Estado: adaptación avanzada.** El árbol ya fue adaptado en gran parte a
LineageOS 20 / Android 13 y actualmente se encuentra en etapa de compilación
y pruebas. Ver README de `device/samsung/j2lte` y los documentos
`ANALISIS_*.md` en la raíz del proyecto.

## Contenido

| Ruta                                                                  | Estado                                                             |
| --------------------------------------------------------------------- | ------------------------------------------------------------------ |
| `BoardConfigCommon.mk`                                                | Adaptado a LOS20 (clang kernel, VINTF, sepolicy vendor, wifi HIDL) |
| `device-common.mk`                                                    | Adaptado para Android 13                                           |
| `system.prop`                                                         | Propiedades del sistema para LOS20                                 |
| `compatibility_matrix.xml`                                            | Matriz de compatibilidad mediante `DEVICE_MATRIX_FILE`             |
| `configs/cgroups.json` + `task_profiles.json`                         | Configuración requerida por init de Android 13 en kernels legacy   |
| `ramdisk/etc/fstab.universal3475`                                     | Adaptado para Android 13, con zram                                 |
| `sepolicy/vendor/`                                                    | Reglas adaptadas para la estructura vendor de LOS20                |
| `camera/`, `hardware/bluetooth/`, `libshims/`, `libsecnativefeature/` | Código heredado de 17.1 adaptado o en proceso de adaptación        |

## Dependencias externas

Los repos SLSI de LineageOS (`exynos`, `exynos5`, `openmax`) llegan como
máximo a `lineage-19.1` en sus ramas originales. Para completar el porte a
LineageOS 20 pueden ser necesarios forks actualizados a T.

Actualmente aparecen como `optional` en `lineage.dependencies`.
