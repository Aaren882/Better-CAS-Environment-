cmake_minimum_required(VERSION 3.10)
set(CMAKE_CXX_STANDARD 23)

# set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}\\bin")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}\\lib")

project(anim_engine)

add_library(anim_engine_x64 SHARED 
	bce_anim_engine/include/arma3headers.h
	bce_anim_engine/src/main.cpp
	bce_anim_engine/include/calculate.h
	bce_anim_engine/src/calculate.cpp
	bce_anim_engine/include/animHandler.h
	bce_anim_engine/src/animHandler.cpp
)

set_target_properties(anim_engine_x64 PROPERTIES
	PREFIX "bce_"
	OUTPUT_NAME "anim_engine_x64"

	# Exact path for Debug builds
	RUNTIME_OUTPUT_DIRECTORY_DEBUG   "${CMAKE_BINARY_DIR}/.."
	# Exact path for Release builds
	RUNTIME_OUTPUT_DIRECTORY_RELEASE "${CMAKE_BINARY_DIR}/.."
)
