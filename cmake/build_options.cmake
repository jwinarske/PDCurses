
option(PDC_BUILD_SHARED "Build dynamic libs for pdcurses" ON)
option(PDC_UTF8 "Force to UTF8" OFF)
option(PDC_WIDE "Wide - pulls in sdl-ttf" OFF)
option(PDCDEBUG "Debug tracing" OFF)
option(PDC_CHTYPE_32 "CHTYPE_32" OFF)
option(PDC_CHTYPE_16 "CHTYPE_16" OFF)
option(PDC_DOS_BUILD "Build DOS Project" OFF)
option(PDC_SDL2_BUILD "Build SDL2 Project" ON)
option(PDC_SDL2_DEPS_BUILD "Build SDL2 and dependencies" ON)

message(STATUS "PDC_BUILD_SHARED ....... ${PDC_BUILD_SHARED}")
message(STATUS "PDC_UTF8 ............... ${PDC_UTF8}")
message(STATUS "PDC_WIDE ............... ${PDC_WIDE}")
message(STATUS "PDCDEBUG ............... ${PDCDEBUG}")
message(STATUS "PDC_CHTYPE_32 .......... ${PDC_CHTYPE_32}")
message(STATUS "PDC_CHTYPE_16 .......... ${PDC_CHTYPE_16}")
message(STATUS "PDC_DOS_BUILD .......... ${PDC_DOS_BUILD}")
message(STATUS "PDC_SDL2_BUILD ......... ${PDC_SDL2_BUILD}")
message(STATUS "PDC_SDL2_DEPS_BUILD .... ${PDC_SDL2_DEPS_BUILD}")


file(TO_CMAKE_PATH "${CMAKE_INSTALL_PREFIX}" CMAKE_INSTALL_PREFIX) # fix up for windows install