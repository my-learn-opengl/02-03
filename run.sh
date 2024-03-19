#!/bin/sh

set -e

cmake -B .cache/build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .
cmake --build .cache/build
cp .cache/build/compile_commands.json .

.cache/build/hello-window
