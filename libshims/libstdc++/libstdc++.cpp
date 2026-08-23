/*
 * V-7 shim: minimal libstdc++ for legacy Samsung blobs.
 *
 * sensors.universal3475.so and camera.vendor.exynos5.so carry DT_NEEDED
 * libstdc++.so, removed from Android since L. Symbol audit of their UND
 * tables shows the only symbols that must come from it are:
 *   _Znwj  operator new(unsigned int)      (32-bit size_t)
 *   _Znaj  operator new[](unsigned int)
 *   _ZdlPv operator delete(void*)
 *   _ZdaPv operator delete[](void*)
 *   __cxa_pure_virtual
 *   __aeabi_unwind_cpp_pr0 / pr1 (ARM EHABI stubs)
 *   __cxa_guard_acquire / __cxa_guard_release / __cxa_guard_abort
 *     (FIX-009: requeridos por libsec-ril.so; ni el blob libstlport.so ni
 *      bionic libc los exportan para este binario)
 * Everything else resolves via libc/liblog/libcutils/libutils.
 *
 * Compiled with stl:"none" (-nostdinc++): C headers only, no STL symbols.
 */

#include <stddef.h>

extern "C" {
void* malloc(size_t);
void free(void*);
void abort();
}

extern "C" void __cxa_pure_virtual() {
    abort();
}

/* ARM EHABI unwind personality stubs (legacy blobs leave them UND). */
extern "C" void __aeabi_unwind_cpp_pr0() {}
extern "C" void __aeabi_unwind_cpp_pr1() {}

void* operator new(size_t size) {
    void* p = malloc(size ? size : 1);
    if (!p) {
        abort();
    }
    return p;
}

void* operator new[](size_t size) {
    return ::operator new(size);
}

void operator delete(void* ptr) noexcept {
    free(ptr);
}

void operator delete[](void* ptr) noexcept {
    free(ptr);
}

/*
 * Itanium guard API (function-local statics). Uses byte 0 of the guard
 * ("initialized" flag per the ABI) to avoid 64-bit alignment issues on
 * arm32. No "in-progress" state: two threads racing the same static init
 * may both run it. Acceptable for legacy blobs; documented in FIX-009.
 */
extern "C" int __cxa_guard_acquire(unsigned char* guard) {
    return __atomic_load_n(guard, __ATOMIC_ACQUIRE) ? 0 : 1;
}

extern "C" void __cxa_guard_release(unsigned char* guard) {
    __atomic_store_n(guard, 1, __ATOMIC_RELEASE);
}

extern "C" void __cxa_guard_abort(unsigned char* guard) {
    (void)guard;
}
