import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "handler.js" as QuestionsHandler

Rectangle {
    id: statsPage

    property string theme: "light"

    Layout.fillWidth: true
    Layout.fillHeight: true
    color: themeObject.backgroundColor

    Component.onCompleted: {
        populateGraphData();
    }

    function populateGraphData() {
        graphData.clear();

        var successData = sessionObject.successfulImplementationsThisMonth;

        for (var questionId in successData) {
            var score = successData[questionId];
            graphData.append({ day: questionId, score: score });
        }

        canvas.requestPaint();
    }

    Text {
        id: title
        anchors.top: parent.top
        anchors.topMargin: 10
        text: "Number of successful implementations per question"
        font.pixelSize: 24
        font.bold: true
        color: themeObject.textColor
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Text {
        anchors.top: title.bottom
        anchors.topMargin: 10
        text: "Evaluates your performance by considering both the success rate and the frequency of problems solved."
        font.pixelSize: 14
        font.bold: false
        color: themeObject.textColor
        anchors.horizontalCenter: parent.horizontalCenter
    }

    ListModel {
        id: graphData
    }

    Canvas {
        id: canvas
        
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.margins: 50

        onPaint: {
            var ctx = canvas.getContext("2d");
            ctx.clearRect(0, 0, canvas.width, canvas.height);

            var padding = 40;
            var graphWidth = canvas.width - padding * 2;
            var graphHeight = canvas.height - padding * 2;

            var maxScore = 0;
            for (var i = 0; i < graphData.count; i++) {
                var point = graphData.get(i);
                if (point.score > maxScore) {
                    maxScore = point.score;
                }
            }

            var yAxisMax = Math.ceil(maxScore / 10) * 10;
            if (yAxisMax === 0) yAxisMax = 10;

            ctx.beginPath();
            ctx.lineWidth = 2;
            ctx.strokeStyle = "#777777";
            ctx.moveTo(padding, padding);
            ctx.lineTo(padding, canvas.height - padding);
            ctx.lineTo(canvas.width - padding, canvas.height - padding);
            ctx.stroke();

            var gridLines = 5;
            ctx.lineWidth = 0.5;
            ctx.strokeStyle = "#cccccc";
            for (var i = 1; i <= gridLines; i++) {
                var y = padding + (graphHeight / gridLines) * i;
                ctx.beginPath();
                ctx.moveTo(padding, y);
                ctx.lineTo(canvas.width - padding, y);
                ctx.stroke();

                ctx.fillStyle = "#777777";
                ctx.font = "12px Arial";
                ctx.fillText(((gridLines - i) * (yAxisMax / gridLines)).toString(), 10, y + 4);
            }

            var barWidth = (graphWidth / graphData.count) - 4;

            for (var i = 0; i < graphData.count; i++) {
                var point = graphData.get(i);
                var xPos = padding + i * (barWidth + 4);
                var barHeight = (point.score / yAxisMax) * graphHeight;
                var yPos = canvas.height - padding - barHeight;

                ctx.beginPath();
                ctx.rect(xPos, yPos, barWidth, barHeight);

                var barColor = "#00c8ff";

                barHeight = point.score

                if (barHeight < 5) {
                    barColor = themeObject.buttonHardColor;
                } else if (barHeight >= 5 && barHeight <= 10) {
                    barColor = themeObject.buttonMediumColor;
                } else {
                    barColor = themeObject.buttonEasyColor;
                }

                ctx.fillStyle = barColor;
                ctx.fill();
                ctx.strokeStyle = barColor;
                ctx.stroke();
            }

            for (var i = 0; i < graphData.count; i++) {
                var point = graphData.get(i);
                var xPos = padding + i * (barWidth + 4) + (barWidth / 2);
                ctx.fillStyle = "#777777";
                ctx.font = "12px Arial";
                ctx.fillText(point.day, xPos - 10, canvas.height - 20);
            }
        }
    }

    ColumnLayout {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 10

        Button {
            id: homeButton
            text: "Go to home"
            width: 200
            height: 50
            onClicked: {
                stackView.pop(2);
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
                radius: 10
                border.width: 1
                border.color: themeObject.buttonColor
                color: homeButton.hovered ? themeObject.buttonHoveredColor : themeObject.buttonColor;
            }
        }
    }
}
