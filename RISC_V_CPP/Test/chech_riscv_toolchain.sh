#!/bin/bash

# RISC-V toolchain prefix (adjust it to your installation path)
TOOLCHAIN_PREFIX="$HOME/riscv32"

# Function to check if a command exists
command_exists() {
  command -v "$1" &>/dev/null
}

# Check if the RISC-V cross-compiler is installed
echo "Checking if RISC-V toolchain is installed..."
if command_exists riscv32-unknown-linux-gnu-gcc; then
  echo "RISC-V cross-compiler found: riscv32-unknown-linux-gnu-gcc"
else
  echo "ERROR: RISC-V cross-compiler 'riscv32-unknown-linux-gnu-gcc' not found!"
  echo "Please install the RISC-V toolchain."
  exit 1
fi

# Check if standard libraries (newlib or glibc) are available
echo "Checking if standard libraries are present..."

if [ -d "$TOOLCHAIN_PREFIX/include" ] && [ -f "$TOOLCHAIN_PREFIX/include/stdio.h" ]; then
  echo "Standard C headers found in '$TOOLCHAIN_PREFIX/include'"
else
  echo "ERROR: Missing standard C headers (stdio.h). You may need to rebuild the toolchain with newlib or glibc."
  exit 1
fi

# Check the sysroot path to ensure it's set correctly
echo "Checking sysroot path..."
if [ -d "$TOOLCHAIN_PREFIX" ]; then
  echo "Sysroot found at '$TOOLCHAIN_PREFIX'."
else
  echo "ERROR: Sysroot directory '$TOOLCHAIN_PREFIX' does not exist."
  exit 1
fi

# Check if toolchain can find the standard library headers and link correctly
echo "Testing the toolchain with a simple 'hello.c' program..."
cat > hello.c <<EOF
#include <stdio.h>
int main() {
    printf("Hello, RISC-V!\n");
    return 0;
}
EOF

riscv32-unknown-linux-gnu-gcc -static hello.c -o hello --sysroot="$TOOLCHAIN_PREFIX" &>/dev/null

if [ $? -eq 0 ]; then
  echo "Toolchain appears to be able to compile and link a simple program."
else
  echo "ERROR: Toolchain failed to compile and link a simple program."
  echo "Please verify your toolchain installation and sysroot configuration."
  exit 1
fi

# Verify if the proper libraries are installed (newlib or glibc)
echo "Checking for available C libraries (newlib/glibc)..."

if [ -d "$TOOLCHAIN_PREFIX/lib" ] && [ "$(ls $TOOLCHAIN_PREFIX/lib)" ]; then
  echo "Libraries found in '$TOOLCHAIN_PREFIX/lib'."
else
  echo "ERROR: No libraries found in '$TOOLCHAIN_PREFIX/lib'."
  echo "You may need to rebuild the toolchain with newlib or glibc."
  exit 1
fi

# Check if the GCC configuration has the correct sysroot and multilib setup
echo "Checking the GCC configuration..."
