#!/system/bin/sh
#
# Diagnostico de arranque (LOS20 / kernel 3.10 exynos3475).
#
# Solo lectura + escritura en /data/local/tmp. No arranca ni detiene ningun
# servicio del sistema.
#
# Por que captura de forma CONTINUA y no con "logcat -d" al final: el device
# arranca con SELinux en permissive=1, lo que genera un flood masivo de
# denegaciones auditadas. Ese flood rota el ring buffer de logcat varias veces
# por segundo, asi que un volcado puntual solo devuelve los ultimos mensajes y
# se pierde todo el arranque (incluidos los errores de zygote). Leyendo en
# bucle desde class core se conserva la secuencia completa.
#
# Salidas en /data/local/tmp (persisten tras un warm reboot a recovery):
#   bootlog.txt   captura continua de todos los buffers
#   st_ps_N.txt   tabla de procesos
#   st_prop_N.txt getprop completo
#   st_crash_N.txt buffer 'crash' (crashes nativos)
#   st_bootN.txt  marca de tiempo de cada volcado

mkdir -p /data/local/tmp

# Captura continua e ininterrumpida. Es lo importante: el resto son volcados.
/system/bin/logcat -b all -v threadtime > /data/local/tmp/bootlog.txt 2>&1 &

/system/bin/date > /data/local/tmp/st_boot0.txt 2>/dev/null

i=1
for t in 30 60 90 150 240 360 480; do
  sleep "$t"
  {
    echo "=== volcado $i ==="
    /system/bin/date
  } > "/data/local/tmp/st_boot$i.txt" 2>/dev/null
  /system/bin/ps -A > "/data/local/tmp/st_ps_$i.txt" 2>/dev/null
  /system/bin/getprop > "/data/local/tmp/st_prop_$i.txt" 2>/dev/null
  /system/bin/logcat -b crash -d -v threadtime > "/data/local/tmp/st_crash_$i.txt" 2>/dev/null
  i=$((i + 1))
done
