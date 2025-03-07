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
SOURCES = src/bit_cuda_ecc.cu src/ecc.cu
OBJECTS = $(patsubst %.cu,$(OBJDIR)/%.o,$(SOURCES))

# Target
TARGET = bit_cuda_ecc.exe

# Rules
all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(NVCC) $(OBJECTS) $(LFLAGS) -o $(TARGET)

$(OBJDIR)/%.o: %.cu
	@mkdir $(OBJDIR) 2>NUL || echo "Directory $(OBJDIR) already exists or cannot be created"
	@mkdir $(OBJDIR)\src 2>NUL || echo "Directory $(OBJDIR)\src already exists or cannot be created"
	$(NVCC) $(NVCCFLAGS) -c $< -o $@

clean:
	if exist $(OBJDIR) del /S /Q $(OBJDIR)\*.o 2>NUL
	del *.exe 2>NUL

.PHONY: all clean