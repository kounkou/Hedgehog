import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: aboutPage
    width: parent.width
    height: parent.height - 10
    color: themeObject.backgroundColor

    ScrollView {
        width: parent.width >> 1
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff

        ListModel {
            id: settingsModel

            ListElement {
                name: "Automatic theme"
                controlType: "Switch"
                icon: "appearance"
            }
            ListElement {
                name: "Bold Text"
                controlType: "Switch"
                icon: "font"
            }
        }

        Column {
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 10
            spacing: 10

            Rectangle {
                id: header
                width: parent.width
                height: 130
                color: themeObject.buttonColor
                border.width: 1
                border.color: themeObject.buttonBorderColor
                radius: 10

                Column {
                    anchors.fill: parent
                    anchors.margins: 20

                    Text {
                        text: "🔩"
                        font.pixelSize: 50
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: "Noto Color Emoji"
                    }

                    Text {
                        id: headerText
                        text: "Settings"
                        font.pixelSize: 24
                        color: themeObject.textColor
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: "Noto Color Emoji"
                    }
                }
            }

            Rectangle {
                width: parent.width
                height: 240
                color: "transparent"
                border.width: 1
                border.color: "transparent"
                radius: 10
                clip: true

                Rectangle {
                    width: parent.width
                    height: 115
                    radius: 10
                    color: themeObject.buttonColor

                    Component {
                        id: settingsDelegate

                        Item {
                            width: parent.width
                            height: 60

                            RowLayout {
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.fill: parent
                                
                                Image {
                                    id: settingItem
                                    anchors.left: parent.left
                                    anchors.leftMargin: 10
                                    Layout.preferredWidth: 30
                                    Layout.preferredHeight: 30
                                    source: {
                                        if (icon === "appearance") { 
                                            return themeObject.theme === "dark" ? "appearance-dark.svg" : "appearance-light.svg"
                                        } else {
                                            return themeObject.theme === "dark" ? "font-dark.svg" : "font-light.svg"
                                        }
                                    }
                                }

                                Text {
                                    text: name
                                    anchors.left: settingItem.right
                                    anchors.leftMargin: 10
                                    font.pixelSize: 14
                                    font.bold: true
                                    color: themeObject.textColor
                                }

                                Loader {
                                    Layout.alignment: Qt.AlignRight
                                    sourceComponent: controlType === "Switch" ? switchComponent : radioButtonComponent
                                    property string itemName: name
                                }
                            }

                            MenuSeparator {
                                width: parent.width - 20
                                anchors.bottom: parent.bottom
                                anchors.horizontalCenter: parent.horizontalCenter
                                visible: index < listView.count - 1
                            }
                        }
                    }

                    ListView {
                        id: listView
                        objectName: "list"
                        anchors.fill: parent
                        model: settingsModel
                        delegate: settingsDelegate
                        focus: true
                        interactive: false
                    }

                    Component {
                        id: switchComponent
                        
                        Switch {
                            checked: itemName === "Automatic theme" ? sessionObject.automaticThemeSetting : sessionObject.fontSetting

                            onToggled: {
                                if (itemName === "Automatic theme") {
                                    sessionObject.automaticThemeSetting = checked;
                                } else {
                                    sessionObject.fontSetting = checked;
                                }

                                sessionObject.saveSession();
                            }
                        }
                    }

                    Timer {
                        id: themeTimer
                        interval: 5000 // 5 seconds interval
                        running: true
                        repeat: true
                        triggeredOnStart: true

                        onTriggered: {
                            sessionObject.loadSession()
                        }
                    }

                    Component {
                        id: radioButtonComponent
                        RadioButton {
                            checked: false
                        }
                    }
                }
            }

            RowLayout {
                spacing: 20
                anchors.horizontalCenter: parent.horizontalCenter

                CustomButton {
                    id: startPractice

                    buttonText: "Start Practicing"
                    page: practicePage
                }

                CustomButton {
                    id: home

                    buttonText: "Go to home"
                    page: welcomePage
                }
            }
        }
    }
}
