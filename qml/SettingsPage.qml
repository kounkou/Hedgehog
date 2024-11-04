import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: settingsObject

    width: parent.width
    height: parent.height - 10
    color: themeObject.backgroundColor

    QtObject {
        id: d

        function maskApiKey(apiKey) {
            if (apiKey.length > 3) {
                return apiKey.slice(0, 3) + '***';
            }

            return apiKey;
        }

        function isMasked(apiKey) {
            return apiKey.contains("***")
        }
    }

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
                controlType: "AppearanceSwitch"
                icon: "appearance"
            }
            ListElement {
                name: "Bold Text"
                controlType: "BoldTextSwitch"
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
                height: 100
                color: themeObject.buttonColor
                border.width: 1
                border.color: themeObject.buttonBorderColor
                radius: 10

                Column {
                    anchors.fill: parent
                    anchors.margins: 20

                    Text {
                        id: headerText
                        text: "Settings"
                        font.pixelSize: 24
                        color: themeObject.textColor
                        font.bold: sessionObject.isFontBold
                        anchors.centerIn: parent
                        font.family: "Noto Color Emoji"
                    }
                }
            }

            Rectangle {
                width: parent.width
                height: 115
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
                    id: appearanceSettings

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
                                    font.bold: sessionObject.isFontBold
                                    color: themeObject.textColor
                                }

                                Loader {
                                    Layout.alignment: Qt.AlignRight
                                    sourceComponent: controlType === "AppearanceSwitch" ? appaeranceSwitchComponent : boldTextSwitchComponent
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
                        id: appaeranceSwitchComponent

                        SwitchDelegate {
                            id: control

                            checked: itemName === "Automatic theme" ? sessionObject.automaticThemeSetting : sessionObject.fontSetting

                            onToggled: {
                                if (itemName === "Automatic theme") {
                                    sessionObject.automaticThemeSetting = checked;
                                } else {
                                    sessionObject.fontSetting = checked;
                                }
                                sessionObject.saveSession();
                            }

                            indicator: Rectangle {
                                implicitWidth: 50
                                implicitHeight: 26
                                x: control.width - width - control.rightPadding + 3
                                y: parent.height / 2 - height / 2
                                radius: 13
                                color: control.checked ? themeObject.buttonEasyColor : "#cccccc"
                                border.color: control.checked ? themeObject.buttonEasyColor : "#cccccc"

                                Rectangle {
                                    x: control.checked ? parent.width - width - 3 : 3
                                    width: 22
                                    height: 22
                                    radius: 11
                                    anchors.verticalCenter: parent.verticalCenter
                                    color: control.down ? "#cccccc" : "#ffffff"
                                    border.color: control.checked ? (control.down ? themeObject.buttonEasyColor : "#21be2b") : "#999999"

                                    Behavior on x {
                                        NumberAnimation { 
                                            duration: 200 
                                            easing.type: Easing.InOutQuad
                                        }
                                    }
                                }
                            }

                            background: Rectangle {
                                implicitWidth: 100
                                implicitHeight: 40
                                visible: false
                                color: control.down ? "#bdbebf" : "#eeeeee"
                            }
                        }
                    }

                    Component {
                        id: boldTextSwitchComponent

                        SwitchDelegate {
                            id: control

                            checked: sessionObject.isFontBold

                            onToggled: {
                                sessionObject.isFontBold = checked
                                sessionObject.saveSession();
                            }

                            indicator: Rectangle {
                                implicitWidth: 50
                                implicitHeight: 26
                                x: control.width - width - control.rightPadding + 3
                                y: parent.height / 2 - height / 2
                                radius: 13
                                color: control.checked ? themeObject.buttonEasyColor : "#cccccc"
                                border.color: control.checked ? themeObject.buttonEasyColor : "#cccccc"
                                opacity: enabled ? 1.0 : 0.5

                                Rectangle {
                                    x: control.checked ? parent.width - width - 3 : 3
                                    width: 22
                                    height: 22
                                    radius: 11
                                    anchors.verticalCenter: parent.verticalCenter
                                    color: control.down ? "#cccccc" : "#ffffff"
                                    border.color: control.checked ? (control.down ? themeObject.buttonEasyColor : "#21be2b") : "#999999"

                                    Behavior on x {
                                        NumberAnimation { 
                                            duration: 200 
                                            easing.type: Easing.InOutQuad
                                        }
                                    }
                                }
                            }

                            background: Rectangle {
                                implicitWidth: 100
                                implicitHeight: 40
                                visible: false
                                color: control.down ? "#bdbebf" : "#eeeeee"
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

            Rectangle {
                width: parent.width
                anchors.top: appearanceSettings.bottom
                anchors.topMargin: 10
                height: 140
                color: themeObject.buttonColor
                border.width: 1
                border.color: themeObject.buttonBorderColor
                radius: 10

                RowLayout {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.fill: parent

                    Text {
                        text: "API KEY"
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        font.pixelSize: 14
                        font.bold: sessionObject.isFontBold
                        color: themeObject.textColor
                    }

                    Rectangle {
                        id: backgroundRect
                        width: parent.width - 100
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        height: 120
                        color: themeObject.textAreaBackgroundColor
                        border.width: 1
                        border.color: themeObject.textAreaBorderColor
                        radius: 10

                        TextArea {
                            anchors.fill: backgroundRect
                            readOnly: submitted
                            placeholderText: sessionObject.apiKey || "Enter your API KEY"
                            // text: sessionObject.apiKey && d.maskApiKey(sessionObject.apiKey)
                            font.family: "Courier New"
                            font.pixelSize: 16
                            font.bold: sessionObject.isFontBold
                            color: themeObject.textColor
                            padding: 10
                            antialiasing: true
                            wrapMode: Text.Wrap
                            palette {
                                highlight: "#B4D5FE"
                                highlightedText: "#202020"
                            }
                            selectByMouse: true

                            onFocusChanged: {
                                if (!focus && text) {
                                    sessionObject.apiKey = text || sessionObject.apiKey
                                    sessionObject.saveSession();
                                }
                            }
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
