import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "handler.js" as QuestionsHandler

Rectangle {
    id: statsPage

    property string theme: "light"
    property string fluctuation: ""
    property string lastUpdateTime: ""

    Layout.fillWidth: true
    Layout.fillHeight: true
    color: themeObject.backgroundColor

    Component.onCompleted: {
        d.populateGraphGaussianData();
        sessionObject.loadSession();
        statsPage.fluctuation = d.getFluctuation();
        statsPage.lastUpdateTime = d.getCurrentTime();
    }

    QtObject {
        id: d

        function getBarColor(barHeight) {
            let baseBlue = Qt.rgba(0, 0, 0.6, 1);
            let lightnessIncrement = Math.min(barHeight * 0.1, 1.0);

            return Qt.darker(baseBlue, 1 - 0.9 * lightnessIncrement);
        }

        function populateGraphRandomData() {
            graphData.clear();

            var successData = sessionObject.successfulImplementationsThisMonth;

            for (var questionId in successData) {
                var score = successData[questionId].count;
                graphData.append({ day: questionId, score: score });
            }

            canvas.requestPaint();
            statsPage.lastUpdateTime = d.getCurrentTime();
        }

        function populateGraphGaussianData() {
            graphData.clear();

            var successData = sessionObject.successfulImplementationsThisMonth;
            var dataArray = [];

            for (var questionId in successData) {
                var score = successData[questionId].count;
                dataArray.push({ day: questionId, score: score });
            }

            dataArray.sort(function(a, b) {
                return b.score - a.score;
            });

            var midIndex = Math.floor(dataArray.length / 2);
            var arrangedData = [];
            
            for (var i = 0; i < dataArray.length; i++) {
                if (i % 2 === 0) {
                    arrangedData[midIndex + Math.floor(i / 2)] = dataArray[i];
                } else {
                    arrangedData[midIndex - Math.ceil(i / 2)] = dataArray[i];
                }
            }

            for (var i = 0; i < arrangedData.length; i++) {
                graphData.append(arrangedData[i]);
            }

            canvas.requestPaint();
            statsPage.lastUpdateTime = d.getCurrentTime();
        }

        function getFluctuation() {
            const { lastDayVisitedNumbers: yesterday, todayVisitedNumbers: today } = sessionObject;

            if (yesterday === 0) {
                return today > 0 
                    ? `⬆ ${today} successful implementations from yesterday` 
                    : "";
            }

            if (today === 0) {
                return `⬇ ${yesterday} successful implementations from yesterday`;
            }

            const difference = today - yesterday;
            const percentageChange = Math.abs((difference / yesterday) * 100).toFixed(2);

            if (difference > 0) {
                return `⬆ ${percentageChange}% from yesterday`;
            } else if (difference < 0) {
                return `⬇ ${percentageChange}% from yesterday`;
            } else {
                return "";
            }
        }

        function getCurrentTime() {
            var date = new Date();
            return date.toLocaleString(); // e.g., "10/31/2024, 3:45 PM"
        }
    }

    Text {
        id: title
        anchors.top: parent.top
        anchors.topMargin: 10
        text: "Number of successful implementations per question"
        font.pixelSize: 24
        font.bold: sessionObject.isFontBold
        color: themeObject.textColor
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Text {
        id: details
        anchors.top: title.bottom
        anchors.topMargin: 10
        text: "Evaluates your performance by considering both the success rate and the frequency of problems solved."
        font.pixelSize: 14
        font.bold: sessionObject.isFontBold
        color: themeObject.textColor
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Text {
        anchors.top: details.bottom
        anchors.topMargin: 10
        text: statsPage.fluctuation
        font.pixelSize: 14
        font.bold: sessionObject.isFontBold
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

                var barColor = d.getBarColor(point.score)

                ctx.fillStyle = barColor;
                ctx.fill();
                ctx.strokeStyle = barColor;
                ctx.stroke();
            }

            for (var i = 0; i < graphData.count; i++) {
                var point = graphData.get(i);
                var xPos = padding + i * (barWidth + 4) + (barWidth / 2);
                var barHeight = (point.score / yAxisMax) * graphHeight;
                var yPos = canvas.height - padding - barHeight - 5;
                ctx.fillStyle = themeObject.textColor;
                ctx.font = "12px Arial";
                ctx.save();
                ctx.translate(xPos, yPos);
                ctx.rotate(-Math.PI / 2); 
                ctx.fillText(point.day, 0, 0);
                ctx.restore();
            }

            // Draw the dotted line at y = 5 LAST to bring it to the front
            var yValue = 5;
            var yPos = canvas.height - padding - ((yValue / yAxisMax) * graphHeight);

            ctx.beginPath();
            ctx.setLineDash([5, 5]); // 5px dash, 5px space
            ctx.strokeStyle = themeObject.averageLineColor; // Color for the average line
            ctx.lineWidth = 1;
            ctx.moveTo(padding, yPos);
            ctx.lineTo(canvas.width - padding, yPos);
            ctx.stroke();
            ctx.setLineDash([]); // Reset to solid lines

            // Add text label at the end of the line
            ctx.fillStyle = themeObject.averageLineColor; // Match line color for consistency
            ctx.font = "12px Arial";
            ctx.fillText("avg 5", canvas.width - 2 * padding, yPos - 4);
        }
    }

    // Updated Time Display
    Text {
        id: updatedTime
        text: "Last updated: " + statsPage.lastUpdateTime
        font.pixelSize: 12
        color: themeObject.textColor
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 50
    }

    RowLayout {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 10

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
