@echo on
REM Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
REM Licensed under the Apache License, Version 2.0 (the "License");

setlocal enabledelayedexpansion

mkdir build

cd build

if errorlevel 1 exit 1

set NVIMG_BUILD_ARGS= ^
    -DBUILD_DOCS:BOOL=OFF ^
    -DBUILD_SAMPLES:BOOL=OFF ^
    -DBUILD_TEST:BOOL=OFF

set NVIMG_LIBRARY_ARGS= ^
    -DBUILD_LIBRARY:BOOL=ON ^
    -DBUILD_SHARED_LIBS:BOOL=ON ^
    -DBUILD_STATIC_LIBS:BOOL=OFF ^
    -DWITH_DYNAMIC_NVJPEG:BOOL=ON ^
    -DWITH_DYNAMIC_NVJPEG2K:BOOL=OFF

set NVIMG_EXT_ARGS= ^
    -DBUILD_EXTENSIONS:BOOL=ON ^
    -DBUILD_NVJPEG_EXT:BOOL=ON ^
    -DBUILD_NVJPEG2K_EXT:BOOL=OFF ^
    -DBUILD_NVBMP_EXT:BOOL=ON ^
    -DBUILD_NVPNM_EXT:BOOL=ON ^
    -DBUILD_LIBJPEG_TURBO_EXT:BOOL=ON ^
    -DBUILD_LIBTIFF_EXT:BOOL=ON ^
    -DBUILD_OPENCV_EXT:BOOL=ON

set NVIMG_PYTHON_ARGS= ^
    -DBUILD_PYTHON:BOOL=OFF ^
    -DNVIMG_CODEC_PYTHON_VERSIONS=%PY_VER% ^
    -DBUILD_WHEEL:BOOL=OFF -DNVIMG_CODEC_COPY_LIBS_TO_PYTHON_DIR:BOOL=OFF ^
    -DNVIMG_CODEC_USE_SYSTEM_PYBIND:BOOL=OFF ^
    -DNVIMG_CODEC_USE_SYSTEM_DLPACK:BOOL=OFF

cmake %CMAKE_ARGS% -GNinja -DCMAKE_INSTALL_PREFIX="%PREFIX%/Library" ^
    %NVIMG_BUILD_ARGS% %NVIMG_LIBRARY_ARGS% %NVIMG_EXT_ARGS% ^
    %NVIMG_PYTHON_ARGS% %SRC_DIR%

if errorlevel 1 exit 1

cmake --build .

if errorlevel 1 exit 1

cmake --install .

endlocal
