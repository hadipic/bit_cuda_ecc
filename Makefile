# Makefile for bit_cuda_ecc
# Modified by Grok 3

# Compiler settings
CXX = g++
NVCC = "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.8\bin\nvcc.exe"
CXXFLAGS = -O2 -Iinclude -I"C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v11.8/include"
NVCCFLAGS = -O2 -Iinclude -I"C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v11.8/include" -gencode=arch=compute_50,code=sm_50
LFLAGS = -L"C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v11.8/lib/x64" -lcudart
OBJDIR = obj

# Source files
SOURCES = main.cpp src/bit_cuda_ecc.cu src/ecc.cu
OBJECTS = $(patsubst %.cpp,$(OBJDIR)/%.o,$(filter %.cpp,$(SOURCES))) $(patsubst %.cu,$(OBJDIR)/%.o,$(filter %.cu,$(SOURCES)))

# Target
TARGET = bit_cuda_ecc.exe

# Rules
all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CXX) $(OBJECTS) $(LFLAGS) -o $(TARGET)

$(OBJDIR)/%.o: %.cpp
	-@if not exist $(OBJDIR) mkdir $(OBJDIR) 2>NUL
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(OBJDIR)/%.o: %.cu
	-@if not exist $(OBJDIR) mkdir $(OBJDIR) 2>NUL
	$(NVCC) $(NVCCFLAGS) -c $< -o $@

clean:
	if exist $(OBJDIR) del /S /Q $(OBJDIR)\*.o 2>NUL
	del *.exe 2>NUL

.PHONY: all clean