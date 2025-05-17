import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes 1.15

Rectangle{
    width: 400
    height: 25
    RowLayout {
        anchors.fill: parent
        spacing: 0 // 可以调整间距

        Button{
            height: parent.height // 高度与父级相同
            background: Rectangle {
                color: "transparent"
            }
            icon.source: "qrc:/icons/read_editor.svg"
            onClicked: console.log("read_editor Clicked")
        }

        Button {
            height: parent.height // 高度与父级相同
            background: Rectangle {
                color: "transparent"
            }
            icon.source: "qrc:/icons/save_editor.svg"
            onClicked: console.log("save_editor Clicked")
        }
        Button {
            height: parent.height // 高度与父级相同
            background: Rectangle {
                color: "transparent"
            }
            icon.source: "qrc:/icons/view_mode_editor.svg"
            onClicked: console.log("view_mode Icon Clicked")
        }
        Button {
            height: parent.height // 高度与父级相同
            background: Rectangle {
                color: "transparent"
            }
            icon.source: "qrc:/icons/word_count_editor.svg"
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
            height: parent.height // 高度与父级相同
            background: Rectangle {
                color: "transparent"
            }
            icon.source: "qrc:/icons/tag.svg"
            onClicked: console.log("tag Icon Clicked")
        }
        Button {
            height: parent.height // 高度与父级相同
            background: Rectangle {
                color: "transparent"
            }
            icon.source: "qrc:/icons/attachment_editor.svg"
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
            height: parent.height // 高度与父级相同
            background: Rectangle {
                color: "transparent"
            }
            icon.source: "qrc:/icons/section_number_editor.svg"
            onClicked: console.log("section_number_editor Icon Clicked")
        }
        Button {
            height: parent.height // 高度与父级相同
            background: Rectangle {
                color: "transparent"
            }
            icon.source: "qrc:/icons/inplace_preview_editor.svg"
            onClicked: console.log("inplace_preview_editor Icon Clicked")
        }
        Button {
            height: parent.height // 高度与父级相同
            background: Rectangle {
                color: "transparent"
            }
            icon.source: "qrc:/icons/image_host_editor.svg"
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
            height: parent.height // 高度与父级相同
            background: Rectangle {
                color: "transparent"
            }
            icon.source: "qrc:/icons/type_heading_editor.svg"
            onClicked: console.log("type_heading_editor Icon Clicked")
        }
        Button {
            height: parent.height // 高度与父级相同
            background: Rectangle {
                color: "transparent"
            }
            icon.source: "qrc:/icons/type_bold_editor.svg"
            onClicked: console.log("type_bold_editor Icon Clicked")
        }
        Button {
            height: parent.height // 高度与父级相同
            background: Rectangle {
                color: "transparent"
            }
            icon.source: "qrc:/icons/type_italic_editor.svg"
            onClicked: console.log("type_italic_editor Icon Clicked")
        }
        Button {
            height: parent.height // 高度与父级相同
            background: Rectangle {
                color: "transparent"
            }
            icon.source: "qrc:/icons/type_strikethrough_editor.svg"
            onClicked: console.log("type_strikethrough_editor Icon Clicked")
        }
        Button {
            height: parent.height // 高度与父级相同
            background: Rectangle {
                color: "transparent"
            }
            icon.source: "qrc:/icons/type_mark_editor.svg"
            onClicked: console.log("type_mark_editor Icon Clicked")
        }
        Button {
            height: parent.height // 高度与父级相同
            background: Rectangle {
                color: "transparent"
            }
            icon.source: "qrc:/icons/type_unordered_list_editor.svg"
            onClicked: console.log("type_unordered_list_editor Icon Clicked")
        }

        Button {
            height: parent.height // 高度与父级相同
            background: Rectangle {
                color: "transparent"
            }
            icon.source: "qrc:/icons/type_ordered_list_editor.svg"
            onClicked: console.log("type_ordered_list_editor Icon Clicked")
        }
        Button {
            height: parent.height // 高度与父级相同
            background: Rectangle {
                color: "transparent"
            }
            icon.source: "qrc:/icons/type_todo_list_editor.svg"
            onClicked: console.log("type_todo_list_editor Icon Clicked")
        }
        Button {
            height: parent.height // 高度与父级相同
            background: Rectangle {
                color: "transparent"
            }
            icon.source: "qrc:/icons/type_checked_todo_list_editor.svg"
            onClicked: console.log("type_ordered_list_editor Icon Clicked")
        }
        Button{
            height: parent.height // 高度与父级相同
            background: Rectangle {
                color: "transparent"
            }
            icon.source: "qrc:/icons/drop_down.svg"
            onClicked: console.log("Down Clicked")
        }
    }
}
