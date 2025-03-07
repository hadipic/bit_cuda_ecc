#include "cuECC/ecc.cuh"
#include "cuECC/u256.cuh"
#include "cuECC/fp.cuh"
#include "cuECC/point.cuh"  // استفاده از تعریف موجود
#include "cuECC/secp256k1.cuh"
#include <iostream>

// حذف تعریف ساختار Point (چون توی point.cuh هست)

// جمع دو نقطه (مثال ساده)
__host__ __device__ Point operator+(const Point& p1, const Point& p2) {
    if (p1.infinity) return p2;
    if (p2.infinity) return p1;
    // اینجا باید پیاده‌سازی جمع نقاط رو از ecc.cu یا point.cuh بیاری
    return Point();
}

// کرنل CUDA برای ضرب نقطه‌ای
__global__ void multiply_point_kernel(Point* points, u256* scalars, Point* result, int n) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < n) {
        Point p = points[idx];
        u256 scalar = scalars[idx];
        Point r = Point();
        for (int i = 255; i >= 0; i--) {
            r = r + r;
            if (scalar.get_bit(i)) {
                r = r + p;
            }
        }
        result[idx] = r;
    }
}

// تابع wrapper برای تولید کلید عمومی
Point generate_public_key(u256 private_key) {
    Point* d_points;
    u256* d_scalars;
    Point* d_result;
    Point result;

    cudaMalloc(&d_points, sizeof(Point));
    cudaMalloc(&d_scalars, sizeof(u256));
    cudaMalloc(&d_result, sizeof(Point));

    Point G = secp256k1::generator; // فرض می‌کنیم این توی secp256k1.cuh تعریف شده

    cudaMemcpy(d_points, &G, sizeof(Point), cudaMemcpyHostToDevice);
    cudaMemcpy(d_scalars, &private_key, sizeof(u256), cudaMemcpyHostToDevice);

    multiply_point_kernel<<<1, 1>>>(d_points, d_scalars, d_result, 1);

    cudaMemcpy(&result, d_result, sizeof(Point), cudaMemcpyDeviceToHost);

    cudaFree(d_points);
    cudaFree(d_scalars);
    cudaFree(d_result);

    return result;
}

// تابع اصلی (برای تست)
extern "C" void run_ecc() {
    u256 private_key("0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef");
    Point public_key = generate_public_key(private_key);
    std::cout << "Public Key X: " << public_key.x.to_string() << std::endl;
    std::cout << "Public Key Y: " << public_key.y.to_string() << std::endl;
}