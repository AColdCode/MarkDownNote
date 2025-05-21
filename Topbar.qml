import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes 1.15

Rectangle{
    width: 400
    height: 25
    Row {
            anchors.fill: parent
            spacing: 0 // 可以调整间距

                Button{
                    width: parent.width * 0.08 // 占据大约18%的宽度
                    height: parent.height // 高度与父级相同
                    background: Rectangle {
                        color: "transparent"
                    }
                    contentItem: Image {
                        source: "qrc:/icons/read_editor.svg"
                        fillMode: Image.PreserveAspectFit
                        width: parent.width * 0.08 // 图标宽度占按钮宽度的80%
                        height: width // 保持宽高比一致
                    }
                    onClicked: console.log("read_editor Clicked")
                }

            Button {
                width: parent.width * 0.08 // 占据大约18%的宽度
                height: parent.height // 高度与父级相同
                background: Rectangle {
                    color: "transparent"
                }
                contentItem: Image {
                    source: "qrc:/icons/save_editor.svg" // 替换为另一个图标的路径
                    fillMode: Image.PreserveAspectFit
                    width: parent.width * 0.08// 图标宽度占按钮宽度的80%
                    height: width // 保持宽高比一致
                }
                onClicked: console.log("save_editor Clicked")
            }
            Button {
                width: parent.width * 0.08 // 占据大约18%的宽度
                height: parent.height // 高度与父级相同
                background: Rectangle {
                    color: "transparent"
                }
                contentItem: Image {
                    source: "qrc:/icons/view_mode_editor.svg"
                    fillMode: Image.PreserveAspectFit
                    width: parent.width * 0.08 // 图标宽度占按钮宽度的80%
                    height: width // 保持宽高比一致
                }
                onClicked: console.log("view_mode Icon Clicked")
            }
            Button {
                width: parent.width * 0.08 // 占据大约18%的宽度
                height: parent.height // 高度与父级相同
                background: Rectangle {
                    color: "transparent"
                }
                contentItem: Image {
                    source: "qrc:/icons/word_count_editor.svg" // 替换为另一个图标的路径
                    fillMode: Image.PreserveAspectFit
                    width: parent.width * 0.08 // 图标宽度占按钮宽度的80%
                    height: width // 保持宽高比一致
                }
                onClicked: console.log("view_mode Icon Clicked")
            }

            // 分割线
            Shape {
                width: 1
                height: parent.height*0.8
                ShapePath {
                                strokeColor: "gray"
                                strokeWidth: 1
                                startX: 0.5; startY: 0 // 起点坐标
                                PathLine { x: 0.5; y: height } // 终点坐标
                            }
            }
            Button {
                width: parent.width * 0.08 // 占据大约18%的宽度
                height: parent.height // 高度与父级相同
                background: Rectangle {
                    color: "transparent"
                }
                contentItem: Image {
                    source: "qrc:/icons/tag.svg" // 替换为另一个图标的路径
                    fillMode: Image.PreserveAspectFit
                    width: parent.width * 0.08 // 图标宽度占按钮宽度的80%
                    height: width // 保持宽高比一致
                }
                onClicked: console.log("tag Icon Clicked")
            }
            Button {
                width: parent.width * 0.08 // 占据大约18%的宽度
                height: parent.height // 高度与父级相同
                background: Rectangle {
                    color: "transparent"
                }
                contentItem: Image {
                    source: "qrc:/icons/attachment_editor.svg" // 替换为另一个图标的路径
                    fillMode: Image.PreserveAspectFit
                    width: parent.width * 0.08 // 图标宽度占按钮宽度的80%
                    height: width // 保持宽高比一致
                }
                onClicked: console.log("attachment_editor Icon Clicked")
            }
            // 分割线
            Shape {
                width: 1
                height: parent.height*0.8
                ShapePath {
                                strokeColor: "gray"
                                strokeWidth: 1
                                startX: 0.5; startY: 0 // 起点坐标
                                PathLine { x: 0.5; y: height } // 终点坐标
                            }
            }
            Button {
                width: parent.width * 0.08 // 占据大约18%的宽度
                height: parent.height // 高度与父级相同
                background: Rectangle {
                    color: "transparent"
                }
                contentItem: Image {
                    source: "qrc:/icons/section_number_editor.svg" // 替换为另一个图标的路径
                    fillMode: Image.PreserveAspectFit
                    width: parent.width * 0.08 // 图标宽度占按钮宽度的80%
                    height: width // 保持宽高比一致
                }
                onClicked: console.log("section_number_editor Icon Clicked")
            }
            Button {
                width: parent.width * 0.08 // 占据大约18%的宽度
                height: parent.height // 高度与父级相同
                background: Rectangle {
                    color: "transparent"
                }
                contentItem: Image {
                    source: "qrc:/icons/inplace_preview_editor.svg" // 替换为另一个图标的路径
                    fillMode: Image.PreserveAspectFit
                    width: parent.width * 0.08 // 图标宽度占按钮宽度的80%
                    height: width // 保持宽高比一致
                }
                onClicked: console.log("inplace_preview_editor Icon Clicked")
            }
            Button {
                width: parent.width * 0.08 // 占据大约18%的宽度
                height: parent.height // 高度与父级相同
                background: Rectangle {
                    color: "transparent"
                }
                contentItem: Image {
                    source: "qrc:/icons/image_host_editor.svg" // 替换为另一个图标的路径
                    fillMode: Image.PreserveAspectFit
                    width: parent.width * 0.08 // 图标宽度占按钮宽度的80%
                    height: width // 保持宽高比一致
                }
                onClicked: console.log("image_host_editor Icon Clicked")
            }
            // 分割线
            Shape {
                width: 1
                height: parent.height*0.8
                ShapePath {
                                strokeColor: "gray"
                                strokeWidth: 1
                                startX: 0.5; startY: 0 // 起点坐标
                                PathLine { x: 0.5; y: height } // 终点坐标
                            }
            }
            Button {
                width: parent.width * 0.08 // 占据大约18%的宽度
                height: parent.height // 高度与父级相同
                background: Rectangle {
                    color: "transparent"
                }
                contentItem: Image {
                    source: "qrc:/icons/type_heading_editor.svg" // 替换为另一个图标的路径
                    fillMode: Image.PreserveAspectFit
                    width: parent.width * 0.08 // 图标宽度占按钮宽度的80%
                    height: width // 保持宽高比一致
                }
                onClicked: console.log("type_heading_editor Icon Clicked")
            }
            Button {
                width: parent.width * 0.08 // 占据大约18%的宽度
                height: parent.height // 高度与父级相同
                background: Rectangle {
                    color: "transparent"
                }
                contentItem: Image {
                    source: "qrc:/icons/type_bold_editor.svg" // 替换为另一个图标的路径
                    fillMode: Image.PreserveAspectFit
                    width: parent.width * 0.08 // 图标宽度占按钮宽度的80%
                    height: width // 保持宽高比一致
                }
                onClicked: console.log("type_bold_editor Icon Clicked")
            }
            Button {
                width: parent.width * 0.08 // 占据大约18%的宽度
                height: parent.height // 高度与父级相同
                background: Rectangle {
                    color: "transparent"
                }
                contentItem: Image {
                    source: "qrc:/icons/type_italic_editor.svg" // 替换为另一个图标的路径
                    fillMode: Image.PreserveAspectFit
                    width: parent.width * 0.08 // 图标宽度占按钮宽度的80%
                    height: width // 保持宽高比一致
                }
                onClicked: console.log("type_italic_editor Icon Clicked")
            }
            Button {
                width: parent.width * 0.08 // 占据大约18%的宽度
                height: parent.height // 高度与父级相同
                background: Rectangle {
                    color: "transparent"
                }
                contentItem: Image {
                    source: "qrc:/icons/type_strikethrough_editor.svg" // 替换为另一个图标的路径
                    fillMode: Image.PreserveAspectFit
                    width: parent.width * 0.08 // 图标宽度占按钮宽度的80%
                    height: width // 保持宽高比一致
                }
                onClicked: console.log("type_strikethrough_editor Icon Clicked")
            }
            Button {
                width: parent.width * 0.08 // 占据大约18%的宽度
                height: parent.height // 高度与父级相同
                background: Rectangle {
                    color: "transparent"
                }
                contentItem: Image {
                    source: "qrc:/icons/type_mark_editor.svg" // 替换为另一个图标的路径
                    fillMode: Image.PreserveAspectFit
                    width: parent.width * 0.08 // 图标宽度占按钮宽度的80%
                    height: width // 保持宽高比一致
                }
                onClicked: console.log("type_mark_editor Icon Clicked")
            }
            Button {
                width: parent.width * 0.08 // 占据大约18%的宽度
                height: parent.height // 高度与父级相同
                background: Rectangle {
                    color: "transparent"
                }
                contentItem: Image {
                    source: "qrc:/icons/type_unordered_list_editor.svg" // 替换为另一个图标的路径
                    fillMode: Image.PreserveAspectFit
                    width: parent.width * 0.08 // 图标宽度占按钮宽度的80%
                    height: width // 保持宽高比一致
                }
                onClicked: console.log("type_unordered_list_editor Icon Clicked")
            }

            Button {
                width: parent.width * 0.08 // 占据大约18%的宽度
                height: parent.height // 高度与父级相同
                background: Rectangle {
                    color: "transparent"
                }
                contentItem: Image {
                    source: "qrc:/icons/type_ordered_list_editor.svg" // 替换为另一个图标的路径
                    fillMode: Image.PreserveAspectFit
                    width: parent.width * 0.08 // 图标宽度占按钮宽度的80%
                    height: width // 保持宽高比一致
                }
                onClicked: console.log("type_ordered_list_editor Icon Clicked")
            }
            Button {
                width: parent.width * 0.08 // 占据大约18%的宽度
                height: parent.height // 高度与父级相同
                background: Rectangle {
                    color: "transparent"
                }
                contentItem: Image {
                    source: "qrc:/icons/type_todo_list_editor.svg" // 替换为另一个图标的路径
                    fillMode: Image.PreserveAspectFit
                    width: parent.width * 0.08 // 图标宽度占按钮宽度的80%
                    height: width // 保持宽高比一致
                }
                onClicked: console.log("type_todo_list_editor Icon Clicked")
            }
            Button {
                width: parent.width * 0.08 // 占据大约18%的宽度
                height: parent.height // 高度与父级相同
                background: Rectangle {
                    color: "transparent"
                }
                contentItem: Image {
                    source: "qrc:/icons/type_checked_todo_list_editor.svg" // 替换为另一个图标的路径
                    fillMode: Image.PreserveAspectFit
                    width: parent.width * 0.08 // 图标宽度占按钮宽度的80%
                    height: width // 保持宽高比一致
                }
                onClicked: console.log("type_ordered_list_editor Icon Clicked")
            }
            Button{
                width: parent.width * 0.08 // 占据大约18%的宽度
                height: parent.height // 高度与父级相同
                background: Rectangle {
                    color: "transparent"
                }
                contentItem: Image {
                    source: "qrc:/themes/vue-dark/down_disabled.svg"
                    fillMode: Image.PreserveAspectFit
                    width: parent.width * 0.08 // 图标宽度占按钮宽度的80%
                    height: width // 保持宽高比一致
                }
                onClicked: console.log("Down Clicked")
            }


        }

}
