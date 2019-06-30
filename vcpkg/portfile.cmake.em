include(vcpkg_common_functions)

set(VCPKG_BUILD_TYPE release)

@[if git_source == 'gitlab']@
vcpkg_from_gitlab(
@[elif git_source == 'github']@
vcpkg_from_github(
@[elif git_source == 'bitbucket']@
vcpkg_from_bitbucket(@[end if]
    OUT_SOURCE_PATH SOURCE_PATH
    REPO @(user_name)/@(repo_name)
    REF @(tag_name)
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

file(INSTALL ${SOURCE_PATH}/license.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/@(Package) RENAME copyright)
file(INSTALL ${SOURCE_PATH}/include/@(Package)_for_vcpkg.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)
