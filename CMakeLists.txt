cmake_minimum_required(VERSION 3.16)

project(MapIntegration VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)


qt_add_executable(appMapIntegration
    main.cpp
)

qt_add_qml_module(appMapIntegration
    URI MapIntegration
    VERSION 1.0
    QML_FILES
        Main.qml
        QML_FILES ui/Components/SearchBar.qml
        QML_FILES ui/Components/OkButton.qml
        QML_FILES ui/Components/MapComponent.qml
        QML_FILES
        QML_FILES ui/Components/Functions.js
)

qt_add_resources(appMapIntegration
    PREFIX /
    FILES
        ui/assets/marker.png
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appMapIntegration PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appMapIntegration
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appMapIntegration
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appMapIntegration
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
