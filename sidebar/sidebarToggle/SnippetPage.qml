import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import MarkDownNote

Rectangle{
    id:snippetPage
    width: parent.width
    height:parent.height
    color:"transparent"
    property string currentTabIndex: MarkDownCtrl.tabBarNames.tabBarName
    property var theModel: MarkDownCtrl.editorModel
    ColumnLayout{
        anchors.fill: parent
        spacing: 5
        Rectangle{
            id:bottonarea1
            Layout.fillWidth: true
            Layout.preferredHeight: 20
            color: "#e0e0e0"
            Button {
                id:button
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                icon.source: "qrc:/icons/close.svg"
                icon.width:12
                icon.height:12
                icon.color:"black"
                background: Rectangle {
                    color: button.hovered ? "lightgray" : "transparent"
                }
                onClicked:{
                    MarkDownCtrl.sidebarCtrl.showLabelChanged("Snippet")
                }
            }
        }
        Item{
            id:bottonarea
            Layout.fillWidth: true
            Layout.preferredHeight: 20

            RowLayout{
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 0
                Item {
                    Layout.preferredWidth: bottonarea.width-showsnippetButton.width-textshow.width
                }

                Button{
                    id:showsnippetButton
                    onClicked: snippetsshow.visible=!snippetsshow.visible
                    icon.source: "qrc:/icons/inplace_preview_editor.svg"
                    icon.width:15
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter


                    background: Rectangle {
                        color: parent.hovered ? "#e0e0e0": "transparent"
                    }
                    ToolTip {
                            parent: showsnippetButton
                            text: "是否显示内建片段"
                            font.pointSize: 8
                            y:22
                            visible: showsnippetButton.hovered
                            delay: 300
                            padding: 4
                    }
                }
                Item{
                    id:textshow
                    Layout.preferredWidth: 40
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Text{

                        text: listView.count +"项"
                        font.family: "Helvetica"
                        font.pointSize: 9
                        anchors.centerIn: textshow
                    }
                }
            }
        }
        ScrollView {
            id: mainScrollView
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.margins: 5
            clip: true

            // 内容区域
            Rectangle {
                id: snippetsshow
                width: mainScrollView.availableWidth  // 使用可用宽度
                height: Math.max(implicitHeight, mainScrollView.availableHeight)  // 动态高度
                color: "transparent"


                // 文件树视图
                ListView {
                    id: listView
                    anchors.fill: parent
                    boundsBehavior: Flickable.StopAtBounds  // 边界行为控制
                    model: ListModel {
                        ListElement { name: "d"; checked: true ;describe:"没有前导零的日期数字（‘1’到‘31’）"}
                        ListElement { name: "dd"; checked: false;describe:"带前导零的日期数字（‘01’到‘31’）" }
                        ListElement { name: "ddd" ; checked: false;describe:"缩写的本地化日期名字（如‘一’到‘日’）" }
                        ListElement { name: "dddd" ; checked: false ;describe:"本地化日期名字（如‘星期一’到‘星期日’）"}
                        ListElement { name: "M" ; checked: false ;describe:"没有前导零的月份数字（‘1’到‘12’）"}
                        ListElement { name: "MM" ; checked: false ;describe:"带前导零的月份数字（‘01’到‘12’）"}
                        ListElement { name: "MMM" ; checked: false ;describe:"缩小的本地化月份名字（如‘一’到‘十二’）"}
                        ListElement { name: "MMMM" ; checked: false ;describe:"本地化月份名字（如‘一月’到‘十二月’）"}
                        ListElement { name: "yy" ; checked: false ;describe:"两位数的年份数字（‘00’到‘99’）"}
                        ListElement { name: "yyyy" ; checked: false ;describe:"四位数的年份数字"}
                        ListElement { name: "w"; checked: false ;describe:"没有前导零的星期数字（‘1’到‘53’）"}
                        ListElement { name: "ww"; checked: false ;describe:"带前导零的日期数字（‘01’到‘53’）"}
                        ListElement { name: "H"; checked: false ;describe:"没有前导零的小时（‘0’到‘23’）"}
                        ListElement { name: "HH"; checked: false ;describe:"带前导零的小时（‘00’到‘23’）"}
                        ListElement { name: "m"; checked: false ;describe:"没有前导零的分（‘0’到‘59’）"}
                        ListElement { name: "mm"; checked: false ;describe:"带前导零的分（‘00’到‘59’）"}
                        ListElement { name: "s"; checked: false ;describe:"没有前导零的秒（‘0’到‘59’）"}
                        ListElement { name: "ss"; checked: false ;describe:"带前导零的秒（‘00’到‘59’）"}
                        ListElement { name: "date"; checked: false ;describe:"日期（‘2021-02-24’）"}
                        ListElement { name: "da"; checked: false ;describe:"缩写的日期（‘20210224’）"}
                        ListElement { name: "time"; checked: false ;describe:"时间（‘16：51：02’）"}
                        ListElement { name: "datetime"; checked: false ;describe:"日期时间（‘2021-02-24_16：51：02’）"}
                        ListElement { name: "note"; checked: false ;describe:"当前笔记名字"}
                        ListElement { name: "no"; checked: false ;describe:"当前笔记的完整基本名字"}
                        // ... 其他列表项 ...
                    }
                    property int selectedIndex: -1

                    // 滚动条设置
                    ScrollBar.vertical: ScrollBar {
                        policy: ScrollBar.AsNeeded  // 按需显示
                        width: 10  // 滚动条宽度
                    }

                    // 代理项
                    delegate: ItemDelegate {
                        id:itemdelegate
                        width: listView.width
                        height: 20
                        Text {
                            id:textarea
                            text: model.name+"*"
                            font.pointSize: 10
                        }
                        // 背景效果
                        background: Rectangle {
                            color: {
                                if (index === listView.selectedIndex) return "#e0e0e0";
                                return hovered ? "#e0e0e0" : "transparent";
                            }
                        }
                        ToolTip {
                                parent: itemdelegate
                                text: model.describe
                                font.pointSize: 8
                                x:50
                                y:22
                                visible: itemdelegate.hovered
                                delay: 300
                                padding: 4
                            }

                        // 鼠标交互
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true

                            onClicked: {
                                listView.selectedIndex = index;

                                // 更新选中状态
                                for (var i = 0; i < listView.model.count; ++i) {
                                    listView.model.setProperty(i, "checked", i === index);
                                }
                                // 生成格式文本
                                var formatText = "";
                                var dateText="";

                                if (index <= 17) { // 0-17项统一处理
                                    formatText = listView.model.get(index).name;
                                    dateText = Qt.formatDateTime(new Date(), formatText);
                                    } else { // 特殊格式单独处理
                                switch(index) {
                                case 18:{
                                    formatText = "yyyy-MM-dd";
                                    dateText = Qt.formatDateTime(new Date(), formatText);
                                    break;
                                }
                                case 19:{
                                    formatText = "yyyyMMdd";
                                    dateText = Qt.formatDateTime(new Date(), formatText);
                                    break;
                                }
                                case 20:{
                                    formatText = "hh:mm:ss";
                                    dateText = Qt.formatDateTime(new Date(), formatText);
                                    break;  // 修正秒数显示
                                }
                                case 21:{
                                    formatText = "yyyy-MM-dd_hh:mm:ss";
                                    dateText = Qt.formatDateTime(new Date(), formatText);
                                    break;
                                }
                                case 22:{

                                    dateText =currentTabIndex;
                                    break;
                                }
                                case 23:{
                                    dateText =currentTabIndex.replace(/\.md$/, "");
                                    break;
                                }
                                }
                                }

                                // 插入到编辑器（仅插入一次）
                                if (dateText !== "") {
                                    MarkDownCtrl.topbarCtrl.insertText(dateText);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


