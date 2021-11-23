function(run_xgettext in_files out_file)
  message(STATUS "Running xgettext")
  IF (COMMAND FIND_HOST_PROGRAM)
    FIND_HOST_PROGRAM (GETTEXT_MSGMERGE_EXECUTABLE msgmerge)
    FIND_HOST_PROGRAM (GETTEXT_MSGFMT_EXECUTABLE msgfmt)
    FIND_HOST_PROGRAM (GETTEXT_MSGCAT_EXECUTABLE msgcat)
    FIND_HOST_PROGRAM (XGETTEXT_EXECUTABLE xgettext)
  ELSE ()
    FIND_PROGRAM (GETTEXT_MSGMERGE_EXECUTABLE msgmerge)
    FIND_PROGRAM (GETTEXT_MSGFMT_EXECUTABLE msgfmt)
    FIND_PROGRAM (GETTEXT_MSGCAT_EXECUTABLE msgcat)
    FIND_PROGRAM (XGETTEXT_EXECUTABLE xgettext)
  ENDIF ()

  set (XGETTEXT_DEFAULT_OPTIONS
      --language=C++
      --keyword=_
      --keyword=_n
      --keyword=_d:1c,2
      --keyword=N_
      --escape
      --add-comments="/"
      --package-name=${PROJECT_NAME}
      --package-version=${PROJECT_VERSION}
      --sort-output
      --msgid-bugs-address=user@mail.com
    )

  set (XGETTEXT_OPTIONS ${XGETTEXT_DEFAULT_OPTIONS})

  execute_process (
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    COMMAND ${XGETTEXT_EXECUTABLE} ${XGETTEXT_OPTIONS} -o ${out_file} ${in_files}
  )
  message(STATUS "Finished running xgettext ${XGETTEXT_EXECUTABLE} ${COMMAND}")
endfunction()
