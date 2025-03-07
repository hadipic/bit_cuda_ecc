#include <iostream>

// اعلان تابع خارجی از bit_cuda_ecc.cu
extern "C" void run_ecc();

int main() {
    std::cout << "Running ECC on GPU...\n";
    run_ecc();
    return 0;
}