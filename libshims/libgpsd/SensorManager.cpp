/*
 * Shim de simbolos para el daemon GPS legacy de Samsung (/vendor/bin/gpsd).
 *
 * gpsd viene de un blob pre-Android-12 y llama a la firma antigua de
 * SensorManager::createEventQueue:
 *
 *   sp<SensorEventQueue> SensorManager::createEventQueue(String8, int)
 *   -> _ZN7android13SensorManager16createEventQueueENS_7String8Ei
 *
 * A partir de Android 12 esa funciongano un tercer argumento (attributionTag),
 * asi que el simbolo con la firma antigua ya no existe en libsensor y el
 * enlazado falla de forma repetida y determinista:
 *
 *   CANNOT LINK EXECUTABLE "/vendor/bin/gpsd": cannot locate symbol
 *   "_ZN7android13SensorManager16createEventQueueENS_7String8Ei"
 *   referenced by "/system/vendor/bin/gpsd"
 *
 * init lo relanza cada 5 segundos, asi que el fallo se repite ~55 veces por
 * arranque y satura el log.
 *
 * Este fichero reexporta el simbolo mangled exacto que el linker busca y lo
 * reenvia a la version de A12+ con el attributionTag vacio. "extern \"C\""
 * es imprescindible: hace que el nombre exportado sea literalmente el
 * mangled en vez de uno derivado de la firma de C++.
 */

#include <sensor/SensorManager.h>
#include <utils/String8.h>
#include <utils/String16.h>
#include <utils/StrongPointer.h>
#include <sensor/SensorEventQueue.h>

namespace android {

extern "C" sp<SensorEventQueue> _ZN7android13SensorManager16createEventQueueENS_7String8Ei(
        SensorManager* manager, String8 packageName, int mode) {
    return manager->createEventQueue(packageName, mode, String16(""));
}

} // namespace android
