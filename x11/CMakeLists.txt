cmake_minimum_required(VERSION 3.11)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "MinSizeRel" CACHE STRING "Choose the type of build, options are: Debug, Release, or MinSizeRel." FORCE)
    message(STATUS "No build type specified, defaulting to MinSizeRel.")
endif()

find_package(PkgConfig)

if(PKG_CONFIG_FOUND)
    pkg_check_modules(X11_Xaw REQUIRED xaw7)
    if (NOT X11_Xaw_FOUND)
        message(FATAL_ERROR "You need libXaw7. On Debian/Ubuntu try `sudo apt-get install libxaw7-dev`")
    endif()
else()
    message(WARNING "There's no pkg-config on this system to check for libXaw7. You may need to try `sudo apt-get install pkg-config`")
endif()

include(FindX11)

if(X11_Xt_FOUND AND X11_Xpm_FOUND AND X11_Xmu_FOUND AND X11_Xaw_FOUND)

    PROJECT(x11 VERSION "${PROJECT_VERSION}" LANGUAGES C)

    set(PDCURSES_DIST ${CMAKE_INSTALL_PREFIX}/${CMAKE_BUILD_TYPE})
    
    file(GLOB x11_src_files ./*.c)

    include_directories(.. ${X11_INCLUDE_DIR}/X11)

    MESSAGE(STATUS "${X11_LIBRARIES}")

    add_library(XCurses-static STATIC ${pdcurses_src_files} ${x11_src_files})
    set_target_properties(XCurses-static PROPERTIES OUTPUT_NAME XCurses)
    target_compile_definitions(XCurses-static PUBLIC -DHAVE_CONFIG_H -DXCURSES)

    add_library(XCurses SHARED ${pdcurses_src_files} ${x11_src_files})
    target_link_libraries(XCurses ${X11_LIBRARIES})
    target_compile_definitions(XCurses PUBLIC -DHAVE_CONFIG_H -DXCURSES -DDYNAMIC)

    macro (demo_app dir targ)
        set(bin_name "${PROJECT_NAME}_${targ}")
        if(${targ} STREQUAL "tuidemo")
            set(src_files ${CMAKE_CURRENT_SOURCE_DIR}/${dir}/tuidemo.c ${CMAKE_CURRENT_SOURCE_DIR}/${dir}/tui.c)
        else()
            set(src_files ${CMAKE_CURRENT_SOURCE_DIR}/${dir}/${targ}.c)
        endif()

        add_executable(${bin_name} ${src_files})
        
        target_link_libraries(${bin_name} XCurses-static 
            ${X11_LIBRARIES} ${X11_Xt_LIB} ${X11_Xpm_LIB} ${X11_Xmu_LIB} ${X11_Xaw_LIBRARIES})

        add_dependencies(${bin_name} XCurses-static)
        set_target_properties(${bin_name} PROPERTIES OUTPUT_NAME ${targ})

        install(TARGETS ${bin_name} RUNTIME DESTINATION ${PDCURSES_DIST}/bin/${PROJECT_NAME} COMPONENT applications)
    endmacro ()

    demo_app(../demos firework)
    demo_app(../demos ozdemo)
    demo_app(../demos newtest)
    demo_app(../demos ptest)
    demo_app(../demos rain)
    demo_app(../demos testcurs)
    demo_app(../demos tuidemo)
    demo_app(../demos worm)
    demo_app(../demos xmas)

    SET(CPACK_COMPONENTS_ALL applications)

endif()