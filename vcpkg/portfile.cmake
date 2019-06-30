include(vcpkg_common_functions)

set(VCPKG_BUILD_TYPE release)

vcpkg_from_github(

    OUT_SOURCE_PATH SOURCE_PATH
    REPO gsoc-bloom-windows/ament_package-release
    REF vcpkg/ros-dashing-ament-package_0.7.0-2_10
)

find_program(PYTHON "python")

if (PYTHON)
    set(SETUP_PY    "${SOURCE_PATH}/setup.py")
    set(OUTPUT      "${SOURCE_PATH}/build")

    add_custom_command(OUTPUT ${OUTPUT}
                       COMMAND ${PYTHON}
                       ARGS setup.py build)

    add_custom_target(target ALL ${OUTPUT})

    install(CODE "execute_process(COMMAND ${PYTHON} ${SETUP_PY} install)")
endif()

file(INSTALL ${SOURCE_PATH}/license.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/ros-dashing-ament-package RENAME copyright)
file(INSTALL ${SOURCE_PATH}/include/ros-dashing-ament-package_for_vcpkg.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)
