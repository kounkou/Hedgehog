import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Button {
    id: root
    property string buttonText: ""
    property var page: null
    property bool isBetaTagEnabled: false

    width: 200
    height: 50
    anchors.horizontalCenter: parent.horizontalCenter

    onClicked: {
        stackView.push(page)
    }

    contentItem: Text {
        text: root.buttonText
        font: root.font
        opacity: enabled ? 1.0 : 0.3
        color: themeObject.textColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        radius: 15
        border.width: 1
        border.color: themeObject.buttonColor
        color: {
            return root.hovered ? themeObject.buttonHoveredColor : themeObject.buttonColor
        }
    }

    Rectangle {
        color: themeObject.buttonColor
        anchors.margins: 8
        border.color: themeObject.buttonHardColor
        border.width: 1
        radius: 15
        visible: root.isBetaTagEnabled
        height: 20
        width: 40
        anchors.verticalCenter: root.verticalCenter
        anchors.right: root.right
        anchors.rightMargin: 5

        Text {
            text: "BETA"
            color: themeObject.buttonHardColor
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 12
            padding: 2
            anchors.centerIn: parent
        }
    }
}
