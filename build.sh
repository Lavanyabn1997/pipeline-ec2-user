#!/bin/bash

# Exit immediately if a command fails
set -e

# Define build directory
BUILD_DIR="build"

# Create build directory if it doesn't exist
if [ ! -d "$BUILD_DIR" ]; then
    mkdir "$BUILD_DIR"
fi

# Navigate to build directory
cd "$BUILD_DIR"

# Run CMake to generate build files
cmake ..

# Compile the project
make

# Run the executable
echo "Running the program..."
./MyApp
