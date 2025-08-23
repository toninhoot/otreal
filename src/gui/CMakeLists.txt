set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt5 COMPONENTS Widgets REQUIRED)

add_executable(canary_gui
    main.cpp
    main_window.cpp
)

target_include_directories(canary_gui PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

target_link_libraries(canary_gui PRIVATE ${PROJECT_NAME}_lib Qt5::Widgets)

configure_linking(canary_gui)
set_output_directory(canary_gui)
