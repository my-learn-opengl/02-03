#!/bin/sh

set -e

git submodule update --init

# glfw
rm -rf tmp/builddir tmp/external
cmake -B tmp/builddir -DCMAKE_INSTALL_PREFIX:PATH=./external submodules/glfw
cmake --build tmp/builddir --target install --config Release --parallel
mv tmp/builddir/external ./tmp
rm -rf tmp/builddir

# glad
python3 -m venv tmp/venv
. tmp/venv/bin/activate
(cd submodules/glad && pip3 install -r requirements.txt && python3 -m glad --out-path=../.. --reproducible --api=gl:core=3.3 c)
deactivate
rm -rf tmp/venv

echo "[
  {
    \"directory\": \"$(pwd)\",
    \"file\": \"src/lib.c\",
    \"output\": \"/dev/null\",
    \"arguments\": [
      \"clang\",
      \"-xc\",
      \"src/main.c\",
      \"-o\",
      \"/dev/null\",
      \"-I\",
      \"external/include\",
      \"-I\",
      \"include\",
      \"-Werror\",
      \"-pedantic\",
      \"-std=c99\",
      \"-Wall\",
      \"-Wextra\",
      \"-Wpedantic\",
      \"-Wcast-qual\",
      \"-Wconversion\",
      \"-Wdouble-promotion\",
      \"-Wduplicated-branches\",
      \"-Wduplicated-cond\",
      \"-Wfloat-equal\",
      \"-Wformat=2\",
      \"-Wformat-signedness\",
      \"-Winit-self\",
      \"-Wlogical-op\",
      \"-Wmissing-declarations\",
      \"-Wmissing-prototypes\",
      \"-Wpadded\",
      \"-Wshadow\",
      \"-Wstrict-prototypes\",
      \"-Wswitch-default\",
      \"-Wswitch-enum\",
      \"-Wundef\",
      \"-Wunused-macros\",
      \"-Wwrite-strings\",
      \"-c\"
    ]
  }
]" > compile_commands.json

rm -rf external
mv tmp/external .
