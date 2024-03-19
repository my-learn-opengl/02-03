#!/bin/sh

set -e

cmake -B tmp/build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .
cmake --build tmp/build
cp tmp/build/compile_commands.json .
