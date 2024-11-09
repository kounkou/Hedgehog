import QtQuick 2.15
import QtQuick.Controls 2.15

SwitchDelegate {
    id: root

    property alias switchText: root.text
    property alias switchChecked: root.checked
    property alias switchEnabled: root.enabled

    signal checkedChangedExternally(bool checked)

    font.bold: sessionObject.isFontBold
    anchors.horizontalCenter: parent.horizontalCenter

    contentItem: Text {
        rightPadding: root.indicator.width + root.spacing
        text: root.text
        font: root.font
        opacity: root.enabled ? 1.0 : 0.5
        color: themeObject.textColor
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
    }

    onCheckedChanged: {
        checkedChangedExternally(root.checked)
        sessionObject.saveSession()
    }

    indicator: Rectangle {
        implicitWidth: 200
        implicitHeight: 26
        x: root.width - width - root.rightPadding + 3
        y: parent.height / 2 - height / 2
        radius: 6
        color: themeObject.backgroundColor
        border.color: themeObject.buttonColor
        opacity: root.enabled ? 1.0 : 0.5

        Rectangle {
            x: root.checked ? parent.width - width - 3 : 3
            width: 100
            height: 20
            radius: 5
            anchors.verticalCenter: parent.verticalCenter
            color: root.down ? themeObject.buttonColor : themeObject.buttonColor
            border.color: themeObject.buttonBorderColor

            Text {
                anchors.centerIn: parent
                text: root.checked ? "Successes" : "Speed"
                font.pixelSize: 14
                font.bold: sessionObject.isFontBold
                color: themeObject.textColor
            }

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
    }
}
