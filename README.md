# cuECC: CUDA-accelerated Elliptic Curve Cryptography Library

## Features

- 256-bit unsigned integer arithmetic operations
- Finite field arithmetic operations
- Elliptic curve point operations
- Parallel public key generation
- Python bindings

## Usage

To use cuECC, follow these steps:
H:\gcc\bit_cuda_ecc\
├── include\
│   ├── cuECC\
│   │   ├── ecc.cuh
│   │   ├── uint256.cuh  (توی پوشه uint)
│   │   ├── field.cuh
│   │   ├── curve.cuh    (توی پوشه curve)
│   │   ├── point.cuh
├── src\
│   ├── ecc.cu
│   ├── uint256.cu      (اگه وجود داره)
│   ├── field.cu        (اگه وجود داره)
│   ├── curve.cu        (اگه وجود داره)
│   ├── point.cu        (اگه وجود داره)
├── Makefile
├── main.cpp            (فایل تست)


-اگه PATH همچنان طولانی باشه و خطای The input line is too long بگیری، می‌تونی PATH رو به حداقل برسونی

@echo off
echo Setting up minimal PATH...
set PATH=%SystemRoot%\system32;%SystemRoot%;%SystemRoot%\System32\Wbem;C:\MinGW\bin;"C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.8\bin"
echo PATH updated successfully!