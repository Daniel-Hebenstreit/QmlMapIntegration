# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/appMapIntegration_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/appMapIntegration_autogen.dir/ParseCache.txt"
  "appMapIntegration_autogen"
  )
endif()
