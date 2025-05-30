import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes 1.15

import MarkDownNote 1.0

Rectangle{
    id: toolbar
    Layout.minimumWidth:100
    height: 40
    color: "#f5f5f5"


    property var toolbarItems: [
        {icon: "qrc:/icons/section_number_editor.svg", text: "小结序号", shortcut: ""},
        {icon: "qrc:/icons/inplace_preview_editor.svg", text: "启用/关闭原地预览", shortcut: ""},
        {icon: "qrc:/icons/image_host_editor.svg", text: "图床", shortcut: ""},
        {icon: "qrc:/icons/type_heading_editor.svg", text: "标题", shortcut: ""},
        {icon: "qrc:/icons/type_bold_editor.svg", text: "粗体", shortcut: "Ctrl+B"},
        {icon: "qrc:/icons/type_italic_editor.svg", text: "斜体", shortcut: "Ctrl+I"},
        {icon: "qrc:/icons/type_strikethrough_editor.svg", text: "删除线", shortcut: ""},
        {icon: "qrc:/icons/type_mark_editor.svg", text: "标记", shortcut: "Ctrl+G,M"},
        {icon: "qrc:/icons/type_unordered_list_editor.svg", text: "无序列表", shortcut: "Ctrl+8"},
        {icon: "qrc:/icons/type_ordered_list_editor.svg", text: "有序列表", shortcut: "Ctrl+9"},
        {icon: "qrc:/icons/type_todo_list_editor.svg", text: "待办列表", shortcut: " "},
        {icon: "qrc:/icons/type_checked_todo_list_editor.svg", text: "已完成待办列表", shortcut: ""},
        {icon: "qrc:/icons/type_code_editor.svg", text: "代码", shortcut: "Ctrl+;"},
        {icon: "qrc:/icons/type_code_block_editor.svg", text: "代码块", shortcut: "Ctrl+'"},
        {icon: "qrc:/icons/type_math_editor.svg", text: "数学公式", shortcut: "Ctrl+."},
        {icon: "qrc:/icons/type_math_block_editor.svg", text: "数学公式块", shortcut: "Ctrl+G,."},
        {icon: "qrc:/icons/type_quote_editor.svg", text: "引用块", shortcut: ""},
        {icon: "qrc:/icons/type_link_editor.svg", text: "链接", shortcut: " Ctrl+,"},
        {icon: "qrc:/icons/type_image_editor.svg", text: "图片", shortcut: ""},
        {icon: "qrc:/icons/type_table_editor.svg", text: "表格", shortcut: "Ctrl+/ "},
        {icon: "qrc:/icons/outline_editor.svg", text: "大纲", shortcut: "Ctrl+G,O"},
        {icon: "qrc:/icons/find_replace_editor.svg", text: "查找替换", shortcut: "Ctrl+F"},
        {icon: "qrc:/icons/print_editor.svg", text: "打印", shortcut: ""},
        {icon: "qrc:/icons/debug_editor.svg", text: "调试", shortcut: "F12"}
    ]

    RowLayout {
        id: mainToolbar
        anchors.fill: parent
        spacing: 2
        Button{
            height: parent.height // 高度与父级相同
            background: Rectangle {
                color: "transparent"
            }
            icon.source: "qrc:/icons/read_editor.svg"
            onClicked: console.log("read_editor Clicked")
            ToolTip.text: `${"阅读"}${" (Ctrl+T)" }`
            ToolTip.visible: hovered
        }

        Button {
            height: parent.height // 高度与父级相同
            background: Rectangle {
                color: "transparent"
            }
            icon.source: "qrc:/icons/save_editor.svg"
            onClicked: console.log("save_editor Clicked")
            ToolTip.text: `${"保存"}${" (Ctrl+S)" }`
            ToolTip.visible: hovered
        }
        Button {
            height: parent.height // 高度与父级相同
            background: Rectangle {
                color: "transparent"
            }
            icon.source: "qrc:/icons/view_mode_editor.svg"
            onClicked: console.log("view_mode Icon Clicked")
            ToolTip.text: `${"查看模式"}${" (Ctrl+G,V)" }`
            ToolTip.visible: hovered
        }
        Button {
            height: parent.height // 高度与父级相同
            background: Rectangle {
                color: "transparent"
            }
            icon.source: "qrc:/icons/word_count_editor.svg"
            onClicked: console.log("view_mode Icon Clicked")
            ToolTip.text: `${"字词统计"}`
            ToolTip.visible: hovered
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
            ToolTip.text: `${"附件" }`
            ToolTip.visible: hovered
        }
        Button {
            height: parent.height // 高度与父级相同
            background: Rectangle {
                color: "transparent"
            }
            icon.source: "qrc:/icons/attachment_editor.svg"
            onClicked: console.log("attachment_editor Icon Clicked")
            ToolTip.text: `${"标签"}${" (Ctrl+G,B)" }`
            ToolTip.visible: hovered
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
        // 主工具栏可见项
        Repeater {
            model: toolbarItems
            delegate: Button {
                visible: Layout.minimumWidth > 0
                icon.source:modelData.icon
                background: Rectangle {
                    color: "transparent"
                }

                Shape {
                    width: 1
                    height: parent.height*0.8
                    visible:index==2
                    ShapePath {
                        strokeColor: "gray"
                        strokeWidth: 1
                        startX: 0.5; startY: 0 // 起点坐标
                        PathLine { x: 0.5; y: height } // 终点坐标
                    }
                }
                // Item {
                //     width: (index === 19) ? 20 : 0
                //     height: parent.height
                // }
                onClicked: {
                    switch(index){
                    case 1:

                        break;
                    case 2:

                        break;
                    case 3:
                        myMenu.popup();
                        break;
                    case 4:
                        MarkDownCtrl.topbarCtrl.onBoldClicked();
                        break;
                    case 5:

                        break;
                    case 6:

                        break;
                    case 7:

                        break;
                    case 8:

                        break;
                    case 9:

                        break;
                    case 10:

                        break;
                    case 11:

                        break;
                    case 12:

                        break;
                    case 13:

                        break;
                    case 14:

                        break;
                    case 15:

                        break;
                    case 16:

                        break;
                    case 17:

                        break;
                    case 18:

                        break;
                    case 19:

                        break;
                    case 20:

                        break;
                    case 21:

                        break;
                    case 22:

                        break;
                    case 23:

                        break;
                    case 24:

                        break;
                    default:
                        console.log("Button at index " + index + " clicked");

                    }

                }
                ToolTip.text: `${modelData.text}${modelData.shortcut ? " ("+modelData.shortcut+")" : ""}`
                ToolTip.visible: hovered
            }
        }

        // 溢出菜单按钮（右侧下拉）
        ToolButton {
            id: overflowMenu
            visible: mainToolbar.childrenRect.width > toolbar.width
            onClicked: menu.popup()

            Menu {
                id: menu
                y: overflowMenu.height

                Repeater {
                    model: toolbarItems
                    delegate: MenuItem {
                        text: `${modelData.text}${modelData.shortcut ? "\t" + modelData.shortcut : ""}`
                        icon.source: modelData.icon
                        onTriggered: console.log("执行:", modelData.text)
                        onClicked: {
                            switch(index){
                            case 1:

                                break;
                            case 2:

                                break;
                            case 3:
                                myMenu.popup();
                                break;
                            case 4:
                                MarkDownCtrl.topbarCtrl.onBoldClicked();
                                break;
                            case 5:

                                break;
                            case 6:

                                break;
                            case 7:

                                break;
                            case 8:

                                break;
                            case 9:

                                break;
                            case 10:

                                break;
                            case 11:

                                break;
                            case 12:

                                break;
                            case 13:

                                break;
                            case 14:

                                break;
                            case 15:

                                break;
                            case 16:

                                break;
                            case 17:

                                break;
                            case 18:

                                break;
                            case 19:

                                break;
                            case 20:

                                break;
                            case 21:

                                break;
                            case 22:

                                break;
                            case 23:

                                break;
                            case 24:

                                break;
                            default:
                                console.log("Button at index " + index + " clicked");

                            }
                        }
                    }
                }
            }
        }
    }

    // 动态计算可见项
    function updateVisibility() {
        var availableWidth = toolbar.width - (overflowMenu.visible ? overflowMenu.width : 0)
        var usedWidth = 0

        for(var i = 0; i < mainToolbar.children.length; i++) {
            var child = mainToolbar.children[i]
            if(child === overflowMenu) continue

            var required = child.implicitWidth + mainToolbar.spacing
            if(usedWidth + required <= availableWidth) {
                child.visible = true
                child.Layout.minimumWidth = child.implicitWidth
                usedWidth += required
            } else {
                child.visible = false
                child.Layout.minimumWidth = 0
            }
        }
    }
    Menu {

        id: myMenu
        MenuItem {
            text: "标题 1"
            onTriggered: MarkDownCtrl.topbarCtrl.menuItemSelected(1)
        }
        MenuItem {
            text: "标题 2"
            onTriggered: MarkDownCtrl.topbarCtrl.menuItemSelected(2)
        }
        MenuItem {
            text: "标题 3"
            onTriggered: MarkDownCtrl.topbarCtrl.menuItemSelected(3)
        }
        MenuItem {
            text: "标题 4"
            onTriggered: MarkDownCtrl.topbarCtrl.menuItemSelected(4)
        }
        MenuItem {
            text: "标题 5"
            onTriggered: MarkDownCtrl.topbarCtrl.menuItemSelected(5)
        }
        MenuItem {
            text: "标题 6"
            onTriggered: MarkDownCtrl.topbarCtrl.menuItemSelected(6)
        }
        MenuItem {
            text: "标题 7"
            onTriggered: MarkDownCtrl.topbarCtrl.menuItemSelected(7)
        }
    }

    onWidthChanged: updateVisibility()
    Component.onCompleted: updateVisibility()
}
