import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: welcomePage

    property string theme: "light"

    width: parent.width
    height: parent.height
    color: themeObject.backgroundColor
    anchors.horizontalCenter: parent.horizontalCenter

    Component.onCompleted: {
        customTimerObject.startTimer()
    }

    Column {
        spacing: 20
        anchors.centerIn: parent

        Text {
            text: "🦔"
            font.pixelSize: 100
            font.family: "Noto Color Emoji"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: "Welcome to Hedgehog"
            font.pixelSize: 24
            font.bold: true
            color: themeObject.textColor
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: "What would you like to do?"
            font.pixelSize: 14
            color: themeObject.textColor
            anchors.horizontalCenter: parent.horizontalCenter
        }

        CustomButton {
            id: questionSelection
            anchors.horizontalCenter: parent.horizontalCenter
            
            buttonText: "Select category"
            page: categoryPage
        }

        CustomButton {
            id: startPractice
            anchors.horizontalCenter: parent.horizontalCenter

            buttonText: "Start Practicing"
            page: practicePage
        }

        // CustomButton {
        //     id: reviewButton

        //     buttonText: "Review algorithms"
        //     page: reviewPage
        // }

        CustomButton {
            id: stats
            anchors.horizontalCenter: parent.horizontalCenter

            buttonText: "Statistics"
            page: statsPage
            isBetaTagEnabled: false
        }

        CustomButton {
            id: settings
            anchors.horizontalCenter: parent.horizontalCenter

            buttonText: "Settings"
            page: settingsPage
        }

        CustomButton {
            id: aboutHedgehog
            anchors.horizontalCenter: parent.horizontalCenter

            buttonText: "About Hedgehog"
            page: aboutPage
        }

        SwitchDelegate {
            id: themeToggle

            font.bold: true
            text: themeObject.theme === "light" ? "Light Theme" : "Dark Theme"
            checked: themeObject.theme === "dark"
            anchors.horizontalCenter: parent.horizontalCenter
            enabled: !sessionObject.automaticThemeSetting

            contentItem: Text {
                    rightPadding: themeToggle.indicator.width + themeToggle.spacing
                    text: themeToggle.text 
                    font: themeToggle.font
                    opacity: enabled ? 1.0 : 0.5
                    color: themeObject.textColor
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
            }

            onCheckedChanged: {
                themeObject.theme = checked ? "dark" : "light"
                sessionObject.saveSession()
            }

            indicator: Rectangle {
                implicitWidth: 50
                implicitHeight: 26
                x: themeToggle.width - width - themeToggle.rightPadding
                y: parent.height / 2 - height / 2
                radius: 13
                color: themeToggle.checked ? themeObject.buttonEasyColor : "#cccccc"
                border.color: themeToggle.checked ? themeObject.buttonEasyColor : "#cccccc"
                opacity: enabled ? 1.0 : 0.5

                Rectangle {
                    x: themeToggle.checked ? parent.width - width : 0
                    width: 26
                    height: 26
                    radius: 13
                    color: themeToggle.down ? "#cccccc" : "#ffffff"
                    border.color: themeToggle.checked ? (themeToggle.down ? themeObject.buttonEasyColor : "#21be2b") : "#999999"

                    Behavior on x {
                        NumberAnimation { duration: 200 }
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
}