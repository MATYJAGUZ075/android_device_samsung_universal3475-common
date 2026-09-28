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
  # Memoria: en un device de 892 MB es la variable critica. zygote pide
  # -Xmx$(dalvik.vm.heapsize) y si no cabe lo mata el OOM killer (en silencio,
  # porque el event file del LMK in-kernel no se puede abrir en este kernel).
  grep -E 'MemTotal|MemFree|MemAvailable|SwapTotal|Slab|SReclaimable' /proc/meminfo \
    > "/data/local/tmp/st_mem_$i.txt" 2>/dev/null
  # dmesg: el ring buffer del kernel DEL ARRANQUE ACTUAL. Es la via directa
  # para ver el kernel log, y no necesita pstore. Importa sobre todo porque
  # el OOM killer loguea ahi, y zygote muere por SIGKILL sin dejar tombstone:
  # si la causa es memoria, la linea aparecera en este fichero.
  /system/bin/dmesg > "/data/local/tmp/st_dmesg_$i.txt" 2>/dev/null

  # pstore: ramoops conserva la consola del kernel entre reinicios, pero
  # /sys/fs/pstore NO viene montado en este device, asi que hay que montarlo a
  # mano antes de copiar. Asi se recupera el kernel log de arranques anteriores.
  mkdir -p /data/local/tmp/pstore 2>/dev/null
  /system/bin/mount -t pstore pstore /sys/fs/pstore 2>/dev/null
  for f in /sys/fs/pstore/*; do
    [ -f "$f" ] || continue
    cp "$f" "/data/local/tmp/pstore/st${i}_$(basename "$f")" 2>/dev/null
  done
  i=$((i + 1))
done
