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
        d.populateGraphSpentTimeData();
        sessionObject.loadSession();
        statsPage.fluctuation = d.getFluctuation();
        statsPage.lastUpdateTime = d.getCurrentTime();
    }

    QtObject {
        id: d

        function getBarColor(barHeight, yAxisMax) {
            let baseRed = 0.4;  // Slightly muted red
            let baseGreen = 0.5;  // Slightly muted green
            let baseBlue = 0.7;  // Softer blue
            let maxHeightFactor = 0.4;  // Reduced to make intensity changes subtler

            let intensity = Math.min(barHeight * maxHeightFactor / yAxisMax, 1.0);

            // Adjust the final colors to stay more subdued
            let red = Math.min(baseRed + intensity * 0.2, 0.7);  // Cap red at a softer level
            let green = Math.min(baseGreen + intensity * 0.2, 0.8);  // Cap green for softer hue
            let blue = Math.max(baseBlue - intensity * 0.2, 0.5);  // Ensure blue stays soft

            return Qt.rgba(red, green, blue, 1.0);
        }

        function populateGraphRandomData() {
            graphData.clear();

            var successData = sessionObject.successfulImplementations;

            for (var questionId in successData) {
                var score = successData[questionId].count;
                graphData.append({ day: questionId, score: score });
            }

            successCanvas.requestPaint();
            statsPage.lastUpdateTime = d.getCurrentTime();
        }

        function populateGraphGaussianData() {
            graphData.clear();

            var successData = sessionObject.successfulImplementations;
            var dataArray = [];

            for (var questionId in successData) {
                var score = successData[questionId].count;

                if (score > 0) {
                    dataArray.push({ day: questionId, score: score });
                }
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

            successCanvas.requestPaint();
            statsPage.lastUpdateTime = d.getCurrentTime();
        }

        function populateGraphSpentTimeData() {
            graphData.clear();

            // Initialize an object to accumulate times for each day
            var daySpentTimes = {
                "Monday": 0,
                "Tuesday": 0,
                "Wednesday": 0,
                "Thursday": 0,
                "Friday": 0,
                "Saturday": 0,
                "Sunday": 0,
            };

            // Loop through each question's data to populate daySpentTimes
            for (var question in sessionObject.successfulImplementations) {
                var data = sessionObject.successfulImplementations[question].spentTime;

                // For each day's data in spentTimes
                for (var dayData of data.spentTimes) {
                    var day = dayData.day;
                    // Ensure the day is within the desired days (Mon-Sat)
                    if (daySpentTimes.hasOwnProperty(day)) {
                        daySpentTimes[day] = data.average;  // Add the average time for that day
                    }
                }
            }

            // Calculate and populate graphData with the average spent time for each day
            for (var day in daySpentTimes) {
                var averageTime = daySpentTimes[day]

                graphData.append({
                    day: day,
                    type: "average",
                    time: averageTime
                });
            }

            speedCanvas.requestPaint();
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
            var today = new Date();
            var hours = today.getHours();
            var minutes = today.getMinutes();

            hours = hours < 10 ? "0" + hours : hours;
            minutes = minutes < 10 ? "0" + minutes : minutes;

            return hours + ":" + minutes;
        }

        function formatTime(seconds) {
            const minutes = Math.floor(seconds / 60);
            const remainingSeconds = seconds % 60;
            return `${minutes}m ${remainingSeconds}s`;
        }
    }

    Text {
        id: title
        anchors.top: parent.top
        anchors.topMargin: 10
        text: successCanvas.visible ? "Number of successful implementations per question." 
            : "Time (in seconds) spent on average implementing a question."
        font.pixelSize: 24
        font.bold: sessionObject.isFontBold
        color: themeObject.textColor
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Text {
        id: details
        anchors.top: title.bottom
        anchors.topMargin: 10
        text: successCanvas.visible ? "Evaluates your performance by considering both the success rate and the frequency of problems solved." 
            : "Monitors the time (in seconds) spent on average when solving any questions on that day."
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
        visible: false
    }

    TogglePageSwitch {
        id: control
        anchors.top: details.bottom
        anchors.topMargin: 10

        onToggled: {
            speedCanvas.visible ? d.populateGraphSpentTimeData() : d.populateGraphGaussianData()
        }
    }

    ListModel {
        id: graphData
    }

    Canvas {
        id: successCanvas
        anchors.fill: parent
        anchors.margins: 100
        visible: control.checked

        onPaint: {
            var ctx = successCanvas.getContext("2d");
            ctx.clearRect(0, 0, successCanvas.width, successCanvas.height);

            var padding = 40;
            var graphWidth = successCanvas.width - padding * 2;
            var graphHeight = successCanvas.height - padding * 2;

            var maxScore = 0;
            for (var i = 0; i < graphData.count; i++) {
                var point = graphData.get(i);
                if (point.score > maxScore) {
                    maxScore = point.score;
                }
            }

            var yAxisMax = Math.ceil(maxScore / 10) * 10;
            if (yAxisMax === 0) yAxisMax = 10;

            // Draw the axes
            ctx.beginPath();
            ctx.lineWidth = 2;
            ctx.strokeStyle = "#777777";
            ctx.moveTo(padding, padding);
            ctx.lineTo(padding, successCanvas.height - padding);
            ctx.lineTo(successCanvas.width - padding, successCanvas.height - padding);
            ctx.stroke();

            var gridLines = 5;
            ctx.lineWidth = 0.5;
            ctx.strokeStyle = "#cccccc";
            for (var i = 1; i <= gridLines; i++) {
                var y = padding + (graphHeight / gridLines) * i;
                ctx.beginPath();
                ctx.moveTo(padding, y);
                ctx.lineTo(successCanvas.width - padding, y);
                ctx.stroke();

                ctx.fillStyle = "#777777";
                ctx.font = "12px Arial";
                ctx.fillText(((gridLines - i) * (yAxisMax / gridLines)).toString(), 10, y + 4);
            }

            // Adjust bar width and spacing
            var barWidth = (graphWidth / graphData.count) * 0.3;  // Reduce bar width to 50% of each segment
            var segmentWidth = graphWidth / graphData.count;
            var cornerRadius = 10;  // Set the radius for the rounded corners

            // Helper function to draw a rounded rectangle
            function drawRoundedRect(ctx, x, y, width, height, radius) {
                if (height === 0) {
                    return;
                }

                ctx.beginPath();
                ctx.moveTo(x + radius, y);
                ctx.lineTo(x + width - radius, y);
                ctx.quadraticCurveTo(x + width, y, x + width, y + radius);
                ctx.lineTo(x + width, y + height);
                ctx.lineTo(x, y + height);
                ctx.lineTo(x, y + radius);
                ctx.quadraticCurveTo(x, y, x + radius, y);
                ctx.closePath();
            }

            for (var i = 0; i < graphData.count; i++) {
                var point = graphData.get(i);
                var xPos = padding + i * segmentWidth + (segmentWidth - barWidth) / 2;  // Center the bar in each segment
                var barHeight = (point.score / yAxisMax) * graphHeight;
                var yPos = successCanvas.height - padding - barHeight;

                ctx.save();
                var barColor = d.getBarColor(point.score, yAxisMax);
                ctx.fillStyle = barColor;
                ctx.strokeStyle = barColor;

                drawRoundedRect(ctx, xPos, yPos, barWidth, barHeight, cornerRadius);
                ctx.fill();
                ctx.stroke();

                ctx.restore();
            }

            for (var i = 0; i < graphData.count; i++) {
                var point = graphData.get(i);
                var xPos = padding + i * segmentWidth + segmentWidth / 2;
                var barHeight = (point.score / yAxisMax) * graphHeight;
                var yPos = successCanvas.height - padding - barHeight - 5;
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
            var yPos = successCanvas.height - padding - ((yValue / yAxisMax) * graphHeight);

            ctx.beginPath();
            ctx.setLineDash([5, 5]);  // 5px dash, 5px space
            ctx.strokeStyle = themeObject.averageLineColor;  // Color for the average line
            ctx.lineWidth = 2;
            ctx.moveTo(padding, yPos);
            ctx.lineTo(successCanvas.width - padding, yPos);
            ctx.stroke();
            ctx.setLineDash([]);  // Reset to solid lines

            // Add text label at the end of the line
            ctx.fillStyle = themeObject.averageLineColor;  // Match line color for consistency
            ctx.font = "12px Arial";
            ctx.fillText("avg 5", successCanvas.width - 2 * padding, yPos - 4);
        }
    }

    Canvas {
        id: speedCanvas
        anchors.fill: parent
        anchors.margins: 100
        visible: !control.checked

        onPaint: {
            var ctx = speedCanvas.getContext("2d");
            ctx.clearRect(0, 0, speedCanvas.width, speedCanvas.height);

            var padding = 40;
            var graphWidth = speedCanvas.width - padding * 2;
            var graphHeight = speedCanvas.height - padding * 2;

            var maxTime = 0;
            for (var i = 0; i < graphData.count; i++) {
                var point = graphData.get(i);
                if (point.time > maxTime) {
                    maxTime = point.time;
                }
            }

            var yAxisMax = Math.ceil(maxTime / 10) * 10 * 3;
            if (yAxisMax === 0) yAxisMax = 30;

            // Draw the axes
            ctx.beginPath();
            ctx.lineWidth = 2;
            ctx.strokeStyle = "#777777";
            ctx.moveTo(padding, padding);
            ctx.lineTo(padding, speedCanvas.height - padding);
            ctx.lineTo(speedCanvas.width - padding, speedCanvas.height - padding);
            ctx.stroke();

            // Draw y-axis grid lines
            var gridLines = 5;
            ctx.lineWidth = 0.5;
            ctx.strokeStyle = "#cccccc";
            for (var i = 1; i <= gridLines; i++) {
                var y = padding + (graphHeight / gridLines) * i;
                ctx.beginPath();
                ctx.moveTo(padding, y);
                ctx.lineTo(speedCanvas.width - padding, y);
                ctx.stroke();

                ctx.fillStyle = "#777777";
                ctx.font = "12px Arial";
                ctx.fillText(((gridLines - i) * (yAxisMax / gridLines)).toString(), 10, y + 4);
            }

            var barWidth = (graphWidth / graphData.count) * 0.3;
            var segmentWidth = graphWidth / graphData.count;
            var cornerRadius = 10; // Set the radius for the rounded corners

            // Helper function to draw a rounded rectangle
            function drawRoundedRect(ctx, x, y, width, height, radius) {
                if (height === 0) {
                    return;
                }

                ctx.beginPath();
                ctx.moveTo(x + radius, y);
                ctx.lineTo(x + width - radius, y);
                ctx.quadraticCurveTo(x + width, y, x + width, y + radius);
                ctx.lineTo(x + width, y + height);
                ctx.lineTo(x, y + height);
                ctx.lineTo(x, y + radius);
                ctx.quadraticCurveTo(x, y, x + radius, y);
                ctx.closePath();
            }

            for (var i = 0; i < graphData.count; i++) {
                var point = graphData.get(i);
                var xPos = padding + i * segmentWidth + (segmentWidth - barWidth) / 2;  // Center the bar in each segment
                var barHeight = (point.time / yAxisMax) * graphHeight;
                var yPos = speedCanvas.height - padding - barHeight;

                ctx.save();
                var barColor = d.getBarColor(point.time, yAxisMax);
                ctx.fillStyle = barColor;
                ctx.strokeStyle = barColor;

                drawRoundedRect(ctx, xPos, yPos, barWidth, barHeight, cornerRadius);
                ctx.fill();
                ctx.stroke();

                ctx.restore();
            }

            for (var i = 0; i < graphData.count; i++) {
                var point = graphData.get(i);

                if (point.time === 0) continue;

                var xPos = padding + i * segmentWidth + (segmentWidth - barWidth) / 2;
                var barHeight = (point.time / yAxisMax) * graphHeight;
                var yPos = successCanvas.height - padding - barHeight - 5;
                ctx.fillStyle = themeObject.textColor;
                ctx.font = "12px Arial";
                ctx.save();
                ctx.translate(xPos, yPos);
                var textWidth = d.formatTime(point.time).length
                ctx.fillText(d.formatTime(point.time), 0, 0)
                ctx.restore();
            }

            for (var i = 0; i < graphData.count; i++) {
                var point = graphData.get(i);
                var xPos = padding + i * segmentWidth + (segmentWidth - barWidth) / 2;
                var barHeight = (point.time / yAxisMax) * graphHeight;
                var yPos = speedCanvas.height - 25
                ctx.fillStyle = themeObject.textColor;
                ctx.font = "12px Arial";
                ctx.save();
                ctx.translate(xPos, yPos);
                ctx.fillText(point.day, 0, 0);
                ctx.restore();
            }
        }
    }

    Column {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 40

        Text {
            id: updatedTime
            text: "Updated today at " + statsPage.lastUpdateTime
            font.pixelSize: 12
            color: themeObject.textColor
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 50
        }

        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
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
}
