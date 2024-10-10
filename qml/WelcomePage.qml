import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: welcomePage

    property string theme: "light"

    width: parent.width
    height: parent.height
    color: themeObject.backgroundColor

    Column {
        spacing: 20
        anchors.centerIn: parent

        Text {
            text: "🦔"
            font.pixelSize: 100
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: "Welcome to Porcupine"
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
            id: startPractice

            buttonText: "Start Practicing"
            page: practicePage
        }

        // CustomButton {
        //     id: reviewButton

        //     buttonText: "Review algorithms"
        //     page: reviewPage
        // }

        // CustomButton {
        //     id: stats

        //     buttonText: "Statistics"
        //     page: statsPage
        //     isBetaTagEnabled: false
        // }

        CustomButton {
            id: aboutPorcupine

            buttonText: "About Porcupine"
            page: aboutPage
        }

        Switch {
            id: themeToggle
            font.bold: true
            text: themeObject.theme === "light" ? "Light Theme" : "Dark Theme"
            checked: themeObject.theme === "dark"
            anchors.horizontalCenter: parent.horizontalCenter
            onCheckedChanged: {
                themeObject.theme = checked ? "dark" : "light"
            }

            contentItem: Text {
                text: themeToggle.text
                font: themeToggle.font
                opacity: enabled ? 1.0 : 0.3
                color: themeObject.textColor
                verticalAlignment: Text.AlignVCenter
                leftPadding: themeToggle.indicator.width + themeToggle.spacing
            }
        }
    }
}