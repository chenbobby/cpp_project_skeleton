### Project configuration

# Set the shell command.
SHELL := /usr/bin/env bash

# Set the C++ compiler.
CC := clang
CXX := $(CC)++

# Set the name of the source directory.
SRC_DIR := ./src

# List all include directories.
INC_DIRS := $(shell find $(SRC_DIR) -type d)

# Set the name of the build directory.
BUILD_DIR := ./build

# Set the name of the target executable.
TARGET_EXEC := kc

# List all source files.
SRCS := $(shell find $(SRC_DIR) -name '*.cpp')

# List all object files. Object files are written to the build directory.
# ./src/**/*.cpp => ./build/**/*.o
OBJS := $(SRCS:$(SRC_DIR)/%.cpp=$(BUILD_DIR)/%.o)

### Environment variables

ENV_VARS := MACOSX_DEPLOYMENT_TARGET=13.3

### Flags

# List all include directories as preprocessor flags.
INC_FLAGS := $(addprefix -I, $(INC_DIRS))

# List all preprocessor flags.
CPP_FLAGS := $(INC_FLAGS)

# Add LLVM include directories to the preprocessor flags.
CPP_FLAGS += -I/usr/local/opt/llvm/include -I/usr/local/opt/llvm/include/c++/v1/

# List all C++ compiler flags;
CXX_FLAGS := -Wall -Wextra -Werror -pedantic-errors -std=c++17

# List all linker flags.
LD_FLAGS := -L/opt/homebrew/opt/llvm/lib/c++ -Wl,-rpath,/opt/homebrew/opt/llvm/lib/c++

### Build commands

# Build the target executable from all object files.
$(BUILD_DIR)/$(TARGET_EXEC): $(OBJS)
	$(ENV_VARS) $(CXX) $(OBJS) -o $@ $(LD_FLAGS)

# Build an object file for each source file.
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	mkdir -p $(dir $@)
	$(ENV_VARS) $(CXX) $(CPP_FLAGS) $(CXX_FLAGS) -c $< -o $@

# Delete all build artifacts.
# Declare `clean` as a `.PHONY` target so that `make` does not expect a file named `clean` to exist.
.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)
