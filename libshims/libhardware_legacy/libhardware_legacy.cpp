/*
 * V-6 shim: minimal libhardware_legacy for legacy Samsung GPS daemon.
 *
 * gpsd (Exynos3475) carries DT_NEEDED libhardware_legacy.so (removed from
 * Android since Q). Full UND audit of the binary shows the only symbols
 * it expects from that library are:
 *   acquire_wake_lock
 *   release_wake_lock
 * Everything else resolves via libc/libcutils/libssl/libcrypto/libicuuc/
 * libgui/libsensor/libutils/libwrappergps/libc++.
 *
 * Classic M-era signatures; writes the lock id to the kernel wakelock sysfs.
 */

#include <fcntl.h>
#include <string.h>
#include <unistd.h>

static int write_wakelock(const char* path, const char* id) {
    int fd = open(path, O_WRONLY | O_CLOEXEC);
    if (fd < 0) {
        return -1;
    }
    ssize_t n = write(fd, id, strlen(id));
    close(fd);
    return n < 0 ? -1 : 0;
}

extern "C" int acquire_wake_lock(int /*lock*/, const char* id) {
    return id ? write_wakelock("/sys/power/wake_lock", id) : -1;
}

extern "C" int release_wake_lock(const char* id) {
    return id ? write_wakelock("/sys/power/wake_unlock", id) : -1;
}
