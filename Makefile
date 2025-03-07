# Makefile for bit_cuda_ecc
# Modified by Grok 3

# Compiler settings
CXX = g++
NVCC = nvcc
CXXFLAGS = -O2 -Iinclude -I"C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v11.8/include"
NVCCFLAGS = -O2 -Iinclude -I"C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v11.8/include" -gencode=arch=compute_50,code=sm_50
LFLAGS = -L"C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v11.8/lib/x64" -lcudart

# Source files
SOURCES = main.cpp src/bit_cuda_ecc.cu src/ecc.cu
OBJECTS = $(SOURCES:.cpp=.o)
OBJECTS := $(OBJECTS:.cu=.o)

# Target
TARGET = bit_cuda_ecc.exe

# Rules
all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CXX) $(OBJECTS) $(LFLAGS) -o $(TARGET)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

%.o: %.cu
	$(NVCC) $(NVCCFLAGS) -c $< -o $@

clean:
	del *.o *.exe src\*.o

.PHONY: all clean