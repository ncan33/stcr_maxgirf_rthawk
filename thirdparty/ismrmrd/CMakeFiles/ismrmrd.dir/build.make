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
include CMakeFiles/ismrmrd.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/ismrmrd.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/ismrmrd.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/ismrmrd.dir/flags.make

CMakeFiles/ismrmrd.dir/libsrc/ismrmrd.c.o: CMakeFiles/ismrmrd.dir/flags.make
CMakeFiles/ismrmrd.dir/libsrc/ismrmrd.c.o: libsrc/ismrmrd.c
CMakeFiles/ismrmrd.dir/libsrc/ismrmrd.c.o: CMakeFiles/ismrmrd.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/Users/nick/research/mrel/ismrmrd/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/ismrmrd.dir/libsrc/ismrmrd.c.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/ismrmrd.dir/libsrc/ismrmrd.c.o -MF CMakeFiles/ismrmrd.dir/libsrc/ismrmrd.c.o.d -o CMakeFiles/ismrmrd.dir/libsrc/ismrmrd.c.o -c /Users/nick/research/mrel/ismrmrd/libsrc/ismrmrd.c

CMakeFiles/ismrmrd.dir/libsrc/ismrmrd.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/ismrmrd.dir/libsrc/ismrmrd.c.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/nick/research/mrel/ismrmrd/libsrc/ismrmrd.c > CMakeFiles/ismrmrd.dir/libsrc/ismrmrd.c.i

CMakeFiles/ismrmrd.dir/libsrc/ismrmrd.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/ismrmrd.dir/libsrc/ismrmrd.c.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/nick/research/mrel/ismrmrd/libsrc/ismrmrd.c -o CMakeFiles/ismrmrd.dir/libsrc/ismrmrd.c.s

CMakeFiles/ismrmrd.dir/libsrc/ismrmrd.cpp.o: CMakeFiles/ismrmrd.dir/flags.make
CMakeFiles/ismrmrd.dir/libsrc/ismrmrd.cpp.o: libsrc/ismrmrd.cpp
CMakeFiles/ismrmrd.dir/libsrc/ismrmrd.cpp.o: CMakeFiles/ismrmrd.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/Users/nick/research/mrel/ismrmrd/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/ismrmrd.dir/libsrc/ismrmrd.cpp.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/ismrmrd.dir/libsrc/ismrmrd.cpp.o -MF CMakeFiles/ismrmrd.dir/libsrc/ismrmrd.cpp.o.d -o CMakeFiles/ismrmrd.dir/libsrc/ismrmrd.cpp.o -c /Users/nick/research/mrel/ismrmrd/libsrc/ismrmrd.cpp

CMakeFiles/ismrmrd.dir/libsrc/ismrmrd.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/ismrmrd.dir/libsrc/ismrmrd.cpp.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/nick/research/mrel/ismrmrd/libsrc/ismrmrd.cpp > CMakeFiles/ismrmrd.dir/libsrc/ismrmrd.cpp.i

CMakeFiles/ismrmrd.dir/libsrc/ismrmrd.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/ismrmrd.dir/libsrc/ismrmrd.cpp.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/nick/research/mrel/ismrmrd/libsrc/ismrmrd.cpp -o CMakeFiles/ismrmrd.dir/libsrc/ismrmrd.cpp.s

CMakeFiles/ismrmrd.dir/libsrc/xml.cpp.o: CMakeFiles/ismrmrd.dir/flags.make
CMakeFiles/ismrmrd.dir/libsrc/xml.cpp.o: libsrc/xml.cpp
CMakeFiles/ismrmrd.dir/libsrc/xml.cpp.o: CMakeFiles/ismrmrd.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/Users/nick/research/mrel/ismrmrd/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/ismrmrd.dir/libsrc/xml.cpp.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/ismrmrd.dir/libsrc/xml.cpp.o -MF CMakeFiles/ismrmrd.dir/libsrc/xml.cpp.o.d -o CMakeFiles/ismrmrd.dir/libsrc/xml.cpp.o -c /Users/nick/research/mrel/ismrmrd/libsrc/xml.cpp

CMakeFiles/ismrmrd.dir/libsrc/xml.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/ismrmrd.dir/libsrc/xml.cpp.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/nick/research/mrel/ismrmrd/libsrc/xml.cpp > CMakeFiles/ismrmrd.dir/libsrc/xml.cpp.i

CMakeFiles/ismrmrd.dir/libsrc/xml.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/ismrmrd.dir/libsrc/xml.cpp.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/nick/research/mrel/ismrmrd/libsrc/xml.cpp -o CMakeFiles/ismrmrd.dir/libsrc/xml.cpp.s

CMakeFiles/ismrmrd.dir/libsrc/meta.cpp.o: CMakeFiles/ismrmrd.dir/flags.make
CMakeFiles/ismrmrd.dir/libsrc/meta.cpp.o: libsrc/meta.cpp
CMakeFiles/ismrmrd.dir/libsrc/meta.cpp.o: CMakeFiles/ismrmrd.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/Users/nick/research/mrel/ismrmrd/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object CMakeFiles/ismrmrd.dir/libsrc/meta.cpp.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/ismrmrd.dir/libsrc/meta.cpp.o -MF CMakeFiles/ismrmrd.dir/libsrc/meta.cpp.o.d -o CMakeFiles/ismrmrd.dir/libsrc/meta.cpp.o -c /Users/nick/research/mrel/ismrmrd/libsrc/meta.cpp

CMakeFiles/ismrmrd.dir/libsrc/meta.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/ismrmrd.dir/libsrc/meta.cpp.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/nick/research/mrel/ismrmrd/libsrc/meta.cpp > CMakeFiles/ismrmrd.dir/libsrc/meta.cpp.i

CMakeFiles/ismrmrd.dir/libsrc/meta.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/ismrmrd.dir/libsrc/meta.cpp.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/nick/research/mrel/ismrmrd/libsrc/meta.cpp -o CMakeFiles/ismrmrd.dir/libsrc/meta.cpp.s

CMakeFiles/ismrmrd.dir/libsrc/waveform.cpp.o: CMakeFiles/ismrmrd.dir/flags.make
CMakeFiles/ismrmrd.dir/libsrc/waveform.cpp.o: libsrc/waveform.cpp
CMakeFiles/ismrmrd.dir/libsrc/waveform.cpp.o: CMakeFiles/ismrmrd.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/Users/nick/research/mrel/ismrmrd/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building CXX object CMakeFiles/ismrmrd.dir/libsrc/waveform.cpp.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/ismrmrd.dir/libsrc/waveform.cpp.o -MF CMakeFiles/ismrmrd.dir/libsrc/waveform.cpp.o.d -o CMakeFiles/ismrmrd.dir/libsrc/waveform.cpp.o -c /Users/nick/research/mrel/ismrmrd/libsrc/waveform.cpp

CMakeFiles/ismrmrd.dir/libsrc/waveform.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/ismrmrd.dir/libsrc/waveform.cpp.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/nick/research/mrel/ismrmrd/libsrc/waveform.cpp > CMakeFiles/ismrmrd.dir/libsrc/waveform.cpp.i

CMakeFiles/ismrmrd.dir/libsrc/waveform.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/ismrmrd.dir/libsrc/waveform.cpp.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/nick/research/mrel/ismrmrd/libsrc/waveform.cpp -o CMakeFiles/ismrmrd.dir/libsrc/waveform.cpp.s

CMakeFiles/ismrmrd.dir/libsrc/waveform.c.o: CMakeFiles/ismrmrd.dir/flags.make
CMakeFiles/ismrmrd.dir/libsrc/waveform.c.o: libsrc/waveform.c
CMakeFiles/ismrmrd.dir/libsrc/waveform.c.o: CMakeFiles/ismrmrd.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/Users/nick/research/mrel/ismrmrd/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building C object CMakeFiles/ismrmrd.dir/libsrc/waveform.c.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/ismrmrd.dir/libsrc/waveform.c.o -MF CMakeFiles/ismrmrd.dir/libsrc/waveform.c.o.d -o CMakeFiles/ismrmrd.dir/libsrc/waveform.c.o -c /Users/nick/research/mrel/ismrmrd/libsrc/waveform.c

CMakeFiles/ismrmrd.dir/libsrc/waveform.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/ismrmrd.dir/libsrc/waveform.c.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/nick/research/mrel/ismrmrd/libsrc/waveform.c > CMakeFiles/ismrmrd.dir/libsrc/waveform.c.i

CMakeFiles/ismrmrd.dir/libsrc/waveform.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/ismrmrd.dir/libsrc/waveform.c.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/nick/research/mrel/ismrmrd/libsrc/waveform.c -o CMakeFiles/ismrmrd.dir/libsrc/waveform.c.s

CMakeFiles/ismrmrd.dir/libsrc/dataset.c.o: CMakeFiles/ismrmrd.dir/flags.make
CMakeFiles/ismrmrd.dir/libsrc/dataset.c.o: libsrc/dataset.c
CMakeFiles/ismrmrd.dir/libsrc/dataset.c.o: CMakeFiles/ismrmrd.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/Users/nick/research/mrel/ismrmrd/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Building C object CMakeFiles/ismrmrd.dir/libsrc/dataset.c.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/ismrmrd.dir/libsrc/dataset.c.o -MF CMakeFiles/ismrmrd.dir/libsrc/dataset.c.o.d -o CMakeFiles/ismrmrd.dir/libsrc/dataset.c.o -c /Users/nick/research/mrel/ismrmrd/libsrc/dataset.c

CMakeFiles/ismrmrd.dir/libsrc/dataset.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/ismrmrd.dir/libsrc/dataset.c.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/nick/research/mrel/ismrmrd/libsrc/dataset.c > CMakeFiles/ismrmrd.dir/libsrc/dataset.c.i

CMakeFiles/ismrmrd.dir/libsrc/dataset.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/ismrmrd.dir/libsrc/dataset.c.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/nick/research/mrel/ismrmrd/libsrc/dataset.c -o CMakeFiles/ismrmrd.dir/libsrc/dataset.c.s

CMakeFiles/ismrmrd.dir/libsrc/dataset.cpp.o: CMakeFiles/ismrmrd.dir/flags.make
CMakeFiles/ismrmrd.dir/libsrc/dataset.cpp.o: libsrc/dataset.cpp
CMakeFiles/ismrmrd.dir/libsrc/dataset.cpp.o: CMakeFiles/ismrmrd.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/Users/nick/research/mrel/ismrmrd/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "Building CXX object CMakeFiles/ismrmrd.dir/libsrc/dataset.cpp.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/ismrmrd.dir/libsrc/dataset.cpp.o -MF CMakeFiles/ismrmrd.dir/libsrc/dataset.cpp.o.d -o CMakeFiles/ismrmrd.dir/libsrc/dataset.cpp.o -c /Users/nick/research/mrel/ismrmrd/libsrc/dataset.cpp

CMakeFiles/ismrmrd.dir/libsrc/dataset.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/ismrmrd.dir/libsrc/dataset.cpp.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/nick/research/mrel/ismrmrd/libsrc/dataset.cpp > CMakeFiles/ismrmrd.dir/libsrc/dataset.cpp.i

CMakeFiles/ismrmrd.dir/libsrc/dataset.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/ismrmrd.dir/libsrc/dataset.cpp.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/nick/research/mrel/ismrmrd/libsrc/dataset.cpp -o CMakeFiles/ismrmrd.dir/libsrc/dataset.cpp.s

CMakeFiles/ismrmrd.dir/libsrc/pugixml.cpp.o: CMakeFiles/ismrmrd.dir/flags.make
CMakeFiles/ismrmrd.dir/libsrc/pugixml.cpp.o: libsrc/pugixml.cpp
CMakeFiles/ismrmrd.dir/libsrc/pugixml.cpp.o: CMakeFiles/ismrmrd.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/Users/nick/research/mrel/ismrmrd/CMakeFiles --progress-num=$(CMAKE_PROGRESS_9) "Building CXX object CMakeFiles/ismrmrd.dir/libsrc/pugixml.cpp.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/ismrmrd.dir/libsrc/pugixml.cpp.o -MF CMakeFiles/ismrmrd.dir/libsrc/pugixml.cpp.o.d -o CMakeFiles/ismrmrd.dir/libsrc/pugixml.cpp.o -c /Users/nick/research/mrel/ismrmrd/libsrc/pugixml.cpp

CMakeFiles/ismrmrd.dir/libsrc/pugixml.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/ismrmrd.dir/libsrc/pugixml.cpp.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/nick/research/mrel/ismrmrd/libsrc/pugixml.cpp > CMakeFiles/ismrmrd.dir/libsrc/pugixml.cpp.i

CMakeFiles/ismrmrd.dir/libsrc/pugixml.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/ismrmrd.dir/libsrc/pugixml.cpp.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/nick/research/mrel/ismrmrd/libsrc/pugixml.cpp -o CMakeFiles/ismrmrd.dir/libsrc/pugixml.cpp.s

# Object files for target ismrmrd
ismrmrd_OBJECTS = \
"CMakeFiles/ismrmrd.dir/libsrc/ismrmrd.c.o" \
"CMakeFiles/ismrmrd.dir/libsrc/ismrmrd.cpp.o" \
"CMakeFiles/ismrmrd.dir/libsrc/xml.cpp.o" \
"CMakeFiles/ismrmrd.dir/libsrc/meta.cpp.o" \
"CMakeFiles/ismrmrd.dir/libsrc/waveform.cpp.o" \
"CMakeFiles/ismrmrd.dir/libsrc/waveform.c.o" \
"CMakeFiles/ismrmrd.dir/libsrc/dataset.c.o" \
"CMakeFiles/ismrmrd.dir/libsrc/dataset.cpp.o" \
"CMakeFiles/ismrmrd.dir/libsrc/pugixml.cpp.o"

# External object files for target ismrmrd
ismrmrd_EXTERNAL_OBJECTS =

libismrmrd.1.11.2.dylib: CMakeFiles/ismrmrd.dir/libsrc/ismrmrd.c.o
libismrmrd.1.11.2.dylib: CMakeFiles/ismrmrd.dir/libsrc/ismrmrd.cpp.o
libismrmrd.1.11.2.dylib: CMakeFiles/ismrmrd.dir/libsrc/xml.cpp.o
libismrmrd.1.11.2.dylib: CMakeFiles/ismrmrd.dir/libsrc/meta.cpp.o
libismrmrd.1.11.2.dylib: CMakeFiles/ismrmrd.dir/libsrc/waveform.cpp.o
libismrmrd.1.11.2.dylib: CMakeFiles/ismrmrd.dir/libsrc/waveform.c.o
libismrmrd.1.11.2.dylib: CMakeFiles/ismrmrd.dir/libsrc/dataset.c.o
libismrmrd.1.11.2.dylib: CMakeFiles/ismrmrd.dir/libsrc/dataset.cpp.o
libismrmrd.1.11.2.dylib: CMakeFiles/ismrmrd.dir/libsrc/pugixml.cpp.o
libismrmrd.1.11.2.dylib: CMakeFiles/ismrmrd.dir/build.make
libismrmrd.1.11.2.dylib: /opt/local/lib/libhdf5.dylib
libismrmrd.1.11.2.dylib: CMakeFiles/ismrmrd.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/Users/nick/research/mrel/ismrmrd/CMakeFiles --progress-num=$(CMAKE_PROGRESS_10) "Linking CXX shared library libismrmrd.dylib"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/ismrmrd.dir/link.txt --verbose=$(VERBOSE)
	$(CMAKE_COMMAND) -E cmake_symlink_library libismrmrd.1.11.2.dylib libismrmrd.1.11.dylib libismrmrd.dylib

libismrmrd.1.11.dylib: libismrmrd.1.11.2.dylib
	@$(CMAKE_COMMAND) -E touch_nocreate libismrmrd.1.11.dylib

libismrmrd.dylib: libismrmrd.1.11.2.dylib
	@$(CMAKE_COMMAND) -E touch_nocreate libismrmrd.dylib

# Rule to build all files generated by this target.
CMakeFiles/ismrmrd.dir/build: libismrmrd.dylib
.PHONY : CMakeFiles/ismrmrd.dir/build

CMakeFiles/ismrmrd.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/ismrmrd.dir/cmake_clean.cmake
.PHONY : CMakeFiles/ismrmrd.dir/clean

CMakeFiles/ismrmrd.dir/depend:
	cd /Users/nick/research/mrel/ismrmrd && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/nick/research/mrel/ismrmrd /Users/nick/research/mrel/ismrmrd /Users/nick/research/mrel/ismrmrd /Users/nick/research/mrel/ismrmrd /Users/nick/research/mrel/ismrmrd/CMakeFiles/ismrmrd.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/ismrmrd.dir/depend

