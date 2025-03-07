#include "..\include\cuECC\u64.cuh"
#include "..\include\cuECC\u256.cuh"
#include "..\include\cuECC\ecc.cuh"
#include "..\include\cuECC\fp.cuh"
#include "..\include\cuECC\point.cuh"
#include "..\include\cuECC\secp256k1.cuh"
#include <iostream>
#include <stdio.h>

// تابع کمکی برای تبدیل u64[4] به هگزادسیمال
std::string u64_array_to_hex(const u64* arr) {
    char hex[65];
    snprintf(hex, sizeof(hex), "%016llx%016llx%016llx%016llx",
             arr[3], arr[2], arr[1], arr[0]);
    return std::string(hex);
}

// تابع اصلی (برای تست)
extern "C" void run_ecc() {
    // تعریف آرایه‌ای از کلیدهای خصوصی (فقط یه عنصر)
    u64 private_keys[1][4] = {
        { 0x1234567890abcdef, 0x1234567890abcdef, 0x1234567890abcdef, 0x1234567890abcdef }
    };
    // آرایه خروجی برای کلید عمومی
    Point public_key[1];

    // فراخوانی تابع از ecc.cu
    getPublicKeyByPrivateKey(public_key, private_keys, 1);

    // نمایش کلید عمومی
    std::cout << "Public Key X: " << u64_array_to_hex(public_key[0].x) << std::endl;
    std::cout << "Public Key Y: " << u64_array_to_hex(public_key[0].y) << std::endl;
}