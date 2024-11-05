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
        implicitWidth: 50
        implicitHeight: 26
        x: root.width - width - root.rightPadding + 3
        y: parent.height / 2 - height / 2
        radius: 13
        color: root.checked ? themeObject.buttonEasyColor : themeObject.buttonDownColor
        border.color: root.checked ? themeObject.buttonEasyColor : themeObject.buttonDownColor
        opacity: root.enabled ? 1.0 : 0.5

        Rectangle {
            x: root.checked ? parent.width - width - 3 : 3
            width: 22
            height: 22
            radius: 11
            anchors.verticalCenter: parent.verticalCenter
            color: root.down ? themeObject.buttonDownColor : themeObject.buttonUpColor
            border.color: root.checked ? (root.down ? themeObject.buttonEasyColor : "#21be2b") : "#999999"

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
