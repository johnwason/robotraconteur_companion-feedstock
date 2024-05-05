#!/bin/sh

set -e

mkdir -p build2
cd build2

if [[ "$CONDA_BUILD_CROSS_COMPILATION" == "1" ]]; then
  export CMAKE_CROSS_ARGS=-DROBOTRACONTEUR_GEN_EXECUTABLE=${BUILD_PREFIX}/bin/RobotRaconteurGen
fi

cmake \
  -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_LIBDIR=lib -DBUILD_SHARED_LIBS:BOOL=ON \
  ${CMAKE_ARGS} ${CMAKE_CROSS_ARGS} \
  ..

cmake --build . --config Release -- -j$CPU_COUNT
cmake --build . --config Release --target install
