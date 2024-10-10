import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: welcomePage

    property string theme: "light"

    width: parent.width
    height: parent.height
    color: themeObject.backgroundColor

    Text {
        id: title
        anchors.top: parent.top
        anchors.topMargin: 10

        text: "Overal session similarity (OSS)"
        font.pixelSize: 14
        font.bold: true
        color: themeObject.textColor
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Text {
        anchors.top: title.bottom
        anchors.topMargin: 10

        text: "Measures your brain similarity over time. Reference code acts as baseline"
        font.pixelSize: 14
        font.bold: false
        color: themeObject.textColor
        anchors.horizontalCenter: parent.horizontalCenter
    }

    ListModel {
        id: graphData
        ListElement { x: 50;  y: 200 }
        ListElement { x: 100; y: 150 }
        ListElement { x: 150; y: 100 }
        ListElement { x: 200; y: 180 }
        ListElement { x: 250; y: 120 }
        ListElement { x: 300; y: 60 }
        ListElement { x: 350; y: 180 }
        ListElement { x: 400; y: 80 }
        ListElement { x: 450; y: 160 }
        ListElement { x: 500; y: 120 }
    }

    Canvas {
        id: canvas
        
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.margins: 50
        
        onPaint: {
            var ctx = canvas.getContext("2d")
            ctx.clearRect(0, 0, canvas.width, canvas.height)  // Clear canvas

            var padding = 40  // Padding for graph boundaries
            var graphWidth = canvas.width - padding * 2
            var graphHeight = canvas.height - padding * 2

            // X and Y axis lines
            ctx.beginPath()
            ctx.lineWidth = 2
            ctx.strokeStyle = "#777777"  // Axis color
            // Y-axis
            // ctx.moveTo(padding, padding)
            // ctx.lineTo(padding, canvas.height - padding)
            // X-axis
            ctx.lineTo(canvas.width - padding, canvas.height - padding)
            ctx.stroke()

            // Grid lines and labels
            var gridLines = 5  // Number of grid lines
            ctx.lineWidth = 0.5
            ctx.strokeStyle = "#cccccc"  // Grid line color
            for (var i = 1; i <= gridLines; i++) {
                var y = padding + (graphHeight / gridLines) * i
                // Horizontal grid lines
                ctx.beginPath()
                ctx.moveTo(padding, y)
                ctx.lineTo(canvas.width - padding, y)
                ctx.stroke()

                // Y-axis labels
                ctx.fillStyle = "#777777"
                ctx.font = "12px Arial"
                ctx.fillText(((gridLines - i) * 20).toString(), 10, y + 4)
            }

            // Plotting data points and lines
            ctx.beginPath()
            var firstPoint = graphData.get(0)
            ctx.moveTo(padding + firstPoint.x, canvas.height - padding - firstPoint.y)

            var gradient = ctx.createLinearGradient(0, 0, 0, canvas.height)
            gradient.addColorStop(0, "rgba(0, 200, 255, 1)")
            gradient.addColorStop(1, "rgba(0, 255, 150, 0.8)")
            ctx.strokeStyle = gradient
            ctx.lineWidth = 3

            // Draw line between points
            for (var i = 1; i < graphData.count; i++) {
                var point = graphData.get(i)
                var xPos = padding + point.x
                var yPos = canvas.height - padding - point.y
                ctx.lineTo(xPos, yPos)
            }
            ctx.stroke()

            // Draw circles at data points
            for (var i = 0; i < graphData.count; i++) {
                var point = graphData.get(i)
                var xPos = padding + point.x
                var yPos = canvas.height - padding - point.y
                ctx.beginPath()
                ctx.arc(xPos, yPos, 4, 0, 2 * Math.PI, false)
                ctx.fillStyle = "#00c8ff"
                ctx.fill()
                ctx.strokeStyle = "#0044ff"
                ctx.stroke()
            }

            // X-axis labels
            for (var i = 0; i < graphData.count; i++) {
                var point = graphData.get(i)
                var xPos = padding + point.x
                ctx.fillStyle = "#777777"
                ctx.font = "12px Arial"
                ctx.fillText((i+1), xPos - 10, canvas.height - 20)
            }
        }
    }

    ColumnLayout {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 10

        Button {
            id: homeButton
            text: "Go to Home"
            width: 200
            height: 50
            onClicked: {
                stackView.pop(2)
            }

            contentItem: Text {
                text: homeButton.text
                font: homeButton.font
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
                    return homeButton.hovered ? themeObject.buttonHoveredColor : themeObject.buttonColor
                }
            }
        }
    }
}
