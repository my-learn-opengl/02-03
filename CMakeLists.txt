cmake_minimum_required(VERSION 3.10)
project(hello-window VERSION 1.0)

file(GLOB_RECURSE SRCS "src/*.c")
include_directories(include)

# glfw
find_package(Git QUIET)
if(GIT_FOUND AND EXISTS "${PROJECT_SOURCE_DIR}/.git")
  option(GIT_SUBMODULE "Check submodules during build" ON)
  if(GIT_SUBMODULE)
    message(STATUS "Submodule update")
    execute_process(COMMAND ${GIT_EXECUTABLE} submodule update --init
                    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                    RESULT_VARIABLE GIT_SUBMOD_RESULT)
    if(NOT GIT_SUBMOD_RESULT EQUAL "0")
      message(FATAL_ERROR "git submodule update --init failed with ${GIT_SUBMOD_RESULT}, please checkout submodules")
    endif()
  endif()
endif()
set(GLFW_BUILD_DOCS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
add_subdirectory(submodules/glfw)

add_executable(${PROJECT_NAME} ${SRCS})
target_link_libraries(${PROJECT_NAME} glfw ${GLFW_LIBRARIES})

if(APPLE)
  target_link_libraries(${PROJECT_NAME} "-framework Cocoa -framework OpenGL -framework IOKit")
endif()
