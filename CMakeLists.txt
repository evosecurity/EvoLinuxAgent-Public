cmake_minimum_required(VERSION 3.11)
project(pam_module C)

include_directories(${CMAKE_SOURCE_DIR}/include)

link_directories(${CMAKE_SOURCE_DIR}/vendor)
link_libraries(evolinuxagent)

set(CMAKE_C_STANDARD 11)

add_library(evo_commonlogin SHARED main.c)
