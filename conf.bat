@echo off
echo Setting up PATH for MinGW, CUDA, Visual Studio, and Make...
set "PATH=C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\MinGW\bin;C:\Espressif\coreutils;C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.8\bin"
echo Activating Visual Studio environment...
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
if %ERRORLEVEL% neq 0 (
    echo Error: Failed to set up Visual Studio environment. Check installation.
    pause
    exit /b %ERRORLEVEL%
)
echo PATH updated successfully: %PATH%
echo Verifying nvcc command...
where nvcc
if %ERRORLEVEL% neq 0 (
    echo Error: 'nvcc' not found in PATH. Check CUDA installation at C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.8\bin.
    dir "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.8\bin\nvcc.exe"
    pause
    exit /b %ERRORLEVEL%
)
echo Verifying make command...
where make
if %ERRORLEVEL% neq 0 (
    echo Error: 'make' not found in PATH. Ensure Make is installed and C:\Espressif\coreutils is in PATH.
    pause
    exit /b %ERRORLEVEL%
)