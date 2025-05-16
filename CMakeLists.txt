cmake_minimum_required(VERSION 3.27)

project(MarkDownNote VERSION 0.1 LANGUAGES CXX)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick WebEngineQuick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appMarkDownNote)

qt_add_qml_module(appMarkDownNote
    URI MarkDownNote
    VERSION 1.0
    QML_FILES Main.qml
    SOURCES main.cpp
    SOURCES markdownconverter.h markdownconverter.cpp
    QML_FILES EditorPage.qml
    QML_FILES NoteManager.qml
    QML_FILES PreviewPage.qml
    QML_FILES NoteContent.qml
    RESOURCES src.qrc
    QML_FILES buttons/MenuButton.qml
    QML_FILES menuManagers/NoteBookMenu.qml
    QML_FILES menuManagers/NewNoteMenu.qml
    QML_FILES menuManagers/ImportMenu.qml
    QML_FILES menuManagers/ExportMenu.qml
    QML_FILES menuManagers/ExpandMenu.qml
    QML_FILES menuManagers/MenuMenu.qml
    QML_FILES buttons/SubMenuButton.qml
    QML_FILES buttons/SplitButton.qml
    QML_FILES menuManagers/menuMenu/HelpMenuButton.qml
    QML_FILES menuManagers/expandMenu/WindowMenuButton.qml
    QML_FILES menuManagers/noteBookMenu/NewNotebookDialog.qml
    QML_FILES menuManagers/noteBookMenu/NewNotebookFromFolderDialog.qml
    QML_FILES menuManagers/noteBookMenu/OpenOtherNotebooksDialog.qml
    QML_FILES menuManagers/noteBookMenu/ManagementNotebookDialog.qml
)

target_compile_features(appMarkDownNote PRIVATE cxx_std_20)

set_target_properties(appMarkDownNote PROPERTIES
    AUTORCC TRUE
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appMarkDownNote
    PRIVATE 
        Qt6::Quick
        Qt6::WebEngineQuick
    )

include(GNUInstallDirs)
install(TARGETS appMarkDownNote
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)























































#qt_add_executable(MarkDownNote)  //Creates and finalizes an application target of a platform-specific type.
#This command performs the following tasks:
#    1. Create a CMake target of the appropriate type for the target platform.
#    2. Link the target to the Qt::Core library.
#    3. Handle finalization of the CMake target.



# qt_standard_project_setup()     #set(CMAKE_AUTOUIC ON)  set(CMAKE_AUTOMOC ON)

# @if %{HasTranslation}
# find_package(Qt6 REQUIRED COMPONENTS Core Quick LinguistTools)
# @else
# find_package(Qt6 REQUIRED COMPONENTS Core Quick)
# @endif

# target_sources(appMarkDownNote
#     PRIVATE
#         main.cpp
#         qml.qrc
#     @if %{HasTranslation}
#         %{TsFileName}
#     @endif
#         
#     PUBLIC
#         
# )

# qt_import_qml_plugins(MarkDownNote)

















# cmake_minimum_required(VERSION 3.16)
# 
# project(MarkDownNote VERSION 0.1 LANGUAGES CXX)
# 
# @if !true
# set(CMAKE_AUTOMOC ON)
# @endif
# set(CMAKE_CXX_STANDARD_REQUIRED ON)
# 
# find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)
# 
# @if true
# @if true
# qt_standard_project_setup(REQUIRES 6.5)
# @else
# qt_standard_project_setup()
# @endif
# @endif
# 
# qt_add_executable(appMarkDownNote
#     main.cpp
# )
# 
# qt_add_qml_module(appMarkDownNote
#     URI MarkDownNote
#     VERSION 1.0
#     QML_FILES Main.qml
# )
# 
# # Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# # If you are developing for iOS or macOS you should consider setting an
# # explicit, fixed bundle identifier manually though.
# set_target_properties(appMarkDownNote PROPERTIES
# #    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appMarkDownNote
#     MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
#     MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
#     MACOSX_BUNDLE TRUE
#     WIN32_EXECUTABLE TRUE
# )
# 
# target_link_libraries(appMarkDownNote
#     PRIVATE Qt6::Quick
# )
# 
# include(GNUInstallDirs)
# install(TARGETS appMarkDownNote
#     BUNDLE DESTINATION .
#     LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
#     RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
# )
