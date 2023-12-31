# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.27

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /opt/homebrew/Cellar/cmake/3.27.7/bin/cmake

# The command to remove a file.
RM = /opt/homebrew/Cellar/cmake/3.27.7/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/nick/research/mrel/ismrmrd

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/nick/research/mrel/ismrmrd

# Include any dependencies generated for this target.
include utilities/CMakeFiles/ismrmrd_info.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include utilities/CMakeFiles/ismrmrd_info.dir/compiler_depend.make

# Include the progress variables for this target.
include utilities/CMakeFiles/ismrmrd_info.dir/progress.make

# Include the compile flags for this target's objects.
include utilities/CMakeFiles/ismrmrd_info.dir/flags.make

utilities/CMakeFiles/ismrmrd_info.dir/ismrmrd_info.cpp.o: utilities/CMakeFiles/ismrmrd_info.dir/flags.make
utilities/CMakeFiles/ismrmrd_info.dir/ismrmrd_info.cpp.o: utilities/ismrmrd_info.cpp
utilities/CMakeFiles/ismrmrd_info.dir/ismrmrd_info.cpp.o: utilities/CMakeFiles/ismrmrd_info.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/Users/nick/research/mrel/ismrmrd/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object utilities/CMakeFiles/ismrmrd_info.dir/ismrmrd_info.cpp.o"
	cd /Users/nick/research/mrel/ismrmrd/utilities && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT utilities/CMakeFiles/ismrmrd_info.dir/ismrmrd_info.cpp.o -MF CMakeFiles/ismrmrd_info.dir/ismrmrd_info.cpp.o.d -o CMakeFiles/ismrmrd_info.dir/ismrmrd_info.cpp.o -c /Users/nick/research/mrel/ismrmrd/utilities/ismrmrd_info.cpp

utilities/CMakeFiles/ismrmrd_info.dir/ismrmrd_info.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/ismrmrd_info.dir/ismrmrd_info.cpp.i"
	cd /Users/nick/research/mrel/ismrmrd/utilities && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/nick/research/mrel/ismrmrd/utilities/ismrmrd_info.cpp > CMakeFiles/ismrmrd_info.dir/ismrmrd_info.cpp.i

utilities/CMakeFiles/ismrmrd_info.dir/ismrmrd_info.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/ismrmrd_info.dir/ismrmrd_info.cpp.s"
	cd /Users/nick/research/mrel/ismrmrd/utilities && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/nick/research/mrel/ismrmrd/utilities/ismrmrd_info.cpp -o CMakeFiles/ismrmrd_info.dir/ismrmrd_info.cpp.s

# Object files for target ismrmrd_info
ismrmrd_info_OBJECTS = \
"CMakeFiles/ismrmrd_info.dir/ismrmrd_info.cpp.o"

# External object files for target ismrmrd_info
ismrmrd_info_EXTERNAL_OBJECTS =

utilities/ismrmrd_info: utilities/CMakeFiles/ismrmrd_info.dir/ismrmrd_info.cpp.o
utilities/ismrmrd_info: utilities/CMakeFiles/ismrmrd_info.dir/build.make
utilities/ismrmrd_info: libismrmrd.1.11.2.dylib
utilities/ismrmrd_info: /opt/local/lib/libhdf5.dylib
utilities/ismrmrd_info: utilities/CMakeFiles/ismrmrd_info.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/Users/nick/research/mrel/ismrmrd/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ismrmrd_info"
	cd /Users/nick/research/mrel/ismrmrd/utilities && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/ismrmrd_info.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
utilities/CMakeFiles/ismrmrd_info.dir/build: utilities/ismrmrd_info
.PHONY : utilities/CMakeFiles/ismrmrd_info.dir/build

utilities/CMakeFiles/ismrmrd_info.dir/clean:
	cd /Users/nick/research/mrel/ismrmrd/utilities && $(CMAKE_COMMAND) -P CMakeFiles/ismrmrd_info.dir/cmake_clean.cmake
.PHONY : utilities/CMakeFiles/ismrmrd_info.dir/clean

utilities/CMakeFiles/ismrmrd_info.dir/depend:
	cd /Users/nick/research/mrel/ismrmrd && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/nick/research/mrel/ismrmrd /Users/nick/research/mrel/ismrmrd/utilities /Users/nick/research/mrel/ismrmrd /Users/nick/research/mrel/ismrmrd/utilities /Users/nick/research/mrel/ismrmrd/utilities/CMakeFiles/ismrmrd_info.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : utilities/CMakeFiles/ismrmrd_info.dir/depend

