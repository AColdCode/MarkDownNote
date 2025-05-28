cmake_minimum_required(VERSION 3.27)

project(
  MarkDownNote
  VERSION 0.1
  LANGUAGES CXX)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick WebEngineQuick Widgets)

qt_standard_project_setup(REQUIRES 6.7)

qt_add_executable(appMarkDownNote)

qt_add_qml_module(
  appMarkDownNote
  URI
  MarkDownNote
  VERSION
  1.0
  QML_FILES
  MarkDownNote.qml
  SOURCES
  main.cpp
  QML_FILES
  leftContent/EditorPage.qml
  QML_FILES
  NoteManager.qml
  QML_FILES
  leftContent/PreviewPage.qml
  QML_FILES
  NoteContent.qml
  RESOURCES
  src.qrc
  QML_FILES
  buttons/MenuButton.qml
  QML_FILES
  menuManagers/NoteBookMenu.qml
  QML_FILES
  menuManagers/NewNoteMenu.qml
  QML_FILES
  menuManagers/ImportMenu.qml
  QML_FILES
  menuManagers/ExportMenu.qml
  QML_FILES
  menuManagers/ExpandMenu.qml
  QML_FILES
  menuManagers/MenuMenu.qml
  QML_FILES
  buttons/SubMenuButton.qml
  QML_FILES
  buttons/SplitButton.qml
  QML_FILES
  menuManagers/menuMenu/HelpMenuButton.qml
  QML_FILES
  menuManagers/expandMenu/WindowMenuButton.qml
  QML_FILES
  menuManagers/noteBookMenu/NewNotebookDialog.qml
  QML_FILES
  menuManagers/noteBookMenu/NewNotebookFromFolderDialog.qml
  QML_FILES
  menuManagers/noteBookMenu/OpenOtherNotebooksDialog.qml
  QML_FILES
  menuManagers/noteBookMenu/ManagementNotebookDialog.qml
  QML_FILES
  leftContent/Topbar.qml
  QML_FILES
  leftContent/WorkspaceMenu.qml
  QML_FILES
  menuManagers/newNoteMenu/NewNoteDialog.qml
  QML_FILES
  menuManagers/newNoteMenu/NewQuickNoteDialog.qml
  QML_FILES
  menuManagers/newNoteMenu/NewFolderDialog.qml
  QML_FILES
  menuManagers/importMenu/ImportFolderDialog.qml
  QML_FILES
  menuManagers/exportMenu/ExportDialog.qml
  SOURCES
  markdownctrl.h
  markdownctrl.cpp
  QML_FILES
  menuManagers/menuMenu/SettingDialog.qml
  QML_FILES
  menuManagers/menuMenu/settingContents/QuickAccessContent.qml
  QML_FILES
  menuManagers/menuMenu/settingContents/GeneralContent.qml
  QML_FILES
  menuManagers/menuMenu/settingContents/dialogs/NewQuickNoteScheme.qml
  QML_FILES
  buttons/ViewButton.qml
  QML_FILES
  buttons/RecycleButton.qml
  QML_FILES
  buttons/Manage_notebooksButton.qml
  QML_FILES
  dialogs/ManageNotebookDialog.qml
  QML_FILES
  sidebar/Sidebar.qml
  QML_FILES
  sidebar/SidebarResponsiveArea.qml
  QML_FILES
  sidebar/sidebarToggle/NavigationPage.qml
  SOURCES
  controllers/editorctrl.h
  controllers/editorctrl.cpp
  SOURCES
  controllers/expandctrl.h
  controllers/expandctrl.cpp
  SOURCES
  controllers/menuctrl.h
  controllers/menuctrl.cpp
  SOURCES
  controllers/previewctrl.h
  controllers/previewctrl.cpp
  SOURCES
  controllers/notebookctrl.h
  controllers/notebookctrl.cpp
  SOURCES
  controllers/newnotesctrl.h
  controllers/newnotesctrl.cpp
  SOURCES
  controllers/importmenuctrl.h
  controllers/importmenuctrl.cpp
  SOURCES
  controllers/exportmenuctrl.h
  controllers/exportmenuctrl.cpp
  QML_FILES LeftContent.qml
  QML_FILES RightContent.qml
  SOURCES models/notebook.h models/notebook.cpp
  SOURCES models/notebooklistmodel.h models/notebooklistmodel.cpp
  SOURCES models/note.h models/note.cpp
  SOURCES models/suffixitem.h models/suffixitem.cpp
  SOURCES models/suffixlistmodel.h models/suffixlistmodel.cpp
  QML_FILES
  sidebar/sidebarToggle/HistoryPage.qml
  QML_FILES
  sidebar/sidebarToggle/SearchPage.qml
  SOURCES
  SOURCES
  controllers/sidebarctrl.h
  controllers/sidebarctrl.cpp
  QML_FILES
  sidebar/sidebarToggle/SearchLocationList.qml
  SOURCES
  controllers/topbarctrl.h
  controllers/topbarctrl.cpp
  SOURCES models/editorentry.h models/editorentry.cpp
  SOURCES models/editormodel.h models/editormodel.cpp
  QML_FILES leftContent/FileNameTabs.qml)

target_compile_features(appMarkDownNote PRIVATE cxx_std_20)

set_target_properties(
  appMarkDownNote
  PROPERTIES AUTORCC TRUE
             MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
             MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
             MACOSX_BUNDLE_SHORT_VERSION_STRING
             ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
             MACOSX_BUNDLE TRUE
             WIN32_EXECUTABLE TRUE)

target_link_libraries(appMarkDownNote PRIVATE Qt6::Quick Qt6::WebEngineQuick
                                              Qt6::Widgets)

include(GNUInstallDirs)
install(
  TARGETS appMarkDownNote
  BUNDLE DESTINATION .
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})

# qt_add_executable(MarkDownNote)  //Creates and finalizes an application target
# of a platform-specific type. This command performs the following tasks: 1.
# Create a CMake target of the appropriate type for the target platform. 2. Link
# the target to the Qt::Core library. 3. Handle finalization of the CMake
# target.

# qt_standard_project_setup()     #set(CMAKE_AUTOUIC ON)  set(CMAKE_AUTOMOC ON)

# @if %{HasTranslation} find_package(Qt6 REQUIRED COMPONENTS Core Quick
# LinguistTools) @else find_package(Qt6 REQUIRED COMPONENTS Core Quick) @endif

# target_sources(appMarkDownNote PRIVATE main.cpp qml.qrc @if %{HasTranslation}
# %{TsFileName} @endif
#
# PUBLIC
#
# )

# qt_import_qml_plugins(MarkDownNote)

# cmake_minimum_required(VERSION 3.16)
#
# project(MarkDownNote VERSION 0.1 LANGUAGES CXX)
#
# @if !true set(CMAKE_AUTOMOC ON) @endif set(CMAKE_CXX_STANDARD_REQUIRED ON)
#
# find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)
#
# @if true @if true qt_standard_project_setup(REQUIRES 6.5) @else
# qt_standard_project_setup() @endif @endif
#
# qt_add_executable(appMarkDownNote main.cpp )
#
# qt_add_qml_module(appMarkDownNote URI MarkDownNote VERSION 1.0 QML_FILES
# Main.qml )
#
# # Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1. #
# If you are developing for iOS or macOS you should consider setting an #
# explicit, fixed bundle identifier manually though.
# set_target_properties(appMarkDownNote PROPERTIES #
# MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appMarkDownNote
# MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
# MACOSX_BUNDLE_SHORT_VERSION_STRING
# ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR} MACOSX_BUNDLE TRUE
# WIN32_EXECUTABLE TRUE )
#
# target_link_libraries(appMarkDownNote PRIVATE Qt6::Quick )
#
# include(GNUInstallDirs) install(TARGETS appMarkDownNote BUNDLE DESTINATION .
# LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR} RUNTIME DESTINATION
# ${CMAKE_INSTALL_BINDIR} )
