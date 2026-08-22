# sepolicy — universal3475-common (LineageOS 20)

Estructura LOS20: todo el policy del device vive en `sepolicy/vendor/` y se
registra vía `BOARD_VENDOR_SEPOLICY_DIRS` en BoardConfigCommon.mk.

## Estado FASE 0

- Reglas migradas textualmente del árbol 17.1 (plataforma Q).
- `SELINUX_IGNORE_NEVERALLOWS := true` activo en BoardConfigCommon.mk durante
  el porte (mismo enfoque que Exynos7420 LOS20).

## Trabajo pendiente (fase 3+)

1. Dominios eliminados en T a remover/refactorizar:
   `fingerprintd.te`, `healthd.te`, `fingerprintd`/`healthd` contexts,
   `wifiloader` parcial.
2. Ajustar sintaxis contra plataforma 33 (atributos nuevos, genfs_contexts
   de /dev/cg2_bpf, linkerconfig, apex, etc.).
3. Endurecer: quitar SELINUX_IGNORE_NEVERALLOWS y resolver cada neverallow.
4. Evaluar migrar reglas compartidas SLSI a un repo común estilo
   `device/samsung_slsi/sepolicy` (referencia Exynos7420).
