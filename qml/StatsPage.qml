import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "handler.js" as QuestionsHandler

Rectangle {
    id: statsPage

    property string theme: "light"
    property string fluctuation: ""
    property string lastUpdateTime: ""
    property var questionColorMap: {}
    property bool detailsButtonCheckedState: false
    property bool dataReady: false

    Layout.fillWidth: true
    Layout.fillHeight: true
    color: themeObject.backgroundColor

    Timer {
        interval: 1 * 60 * 1000
        repeat: true
        running: true
        triggeredOnStart: true

        onTriggered: {
            if (speedCanvas.visible) {
                d.populateGraphSpentTimeData();
            } else if (successCanvas.visible) {
                d.populateGraphGaussianData();
            } else {
                d.populateGraphDetailedSpentTimeData();
            }
        }
    }

    Component.onCompleted: {
        d.populateGraphGaussianData();
        d.populateGraphSpentTimeData();

        sessionObject.loadSession();
        statsPage.fluctuation = d.getFluctuation();
        statsPage.lastUpdateTime = d.getCurrentTime();
        questionListView.populateQuestionModel();
    }

    Connections {
        target: graphData
        function onCountChanged() {
            if (graphData.count > 0) {
                dataReady = true;
                d.populateQuestionModel();
            }
        }
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

        function getCurrentDate() {
            const today = new Date();
            const year = today.getFullYear();
            const month = String(today.getMonth() + 1).padStart(2, '0');
            const day = String(today.getDate()).padStart(2, '0');
            return `${year}-${month}-${day}`;
        }

        function parseDate(dateString) {
            const [year, month, day] = dateString.split('-').map(Number);
            return new Date(year, month - 1, day);
        }

        function getCurrentWeekRange(today) {
            const dayOfWeek = today.getDay();
            const startOfWeek = new Date(today);
            const endOfWeek = new Date(today);

            startOfWeek.setDate(today.getDate() - ((dayOfWeek + 6) % 7));
            endOfWeek.setDate(startOfWeek.getDate() + 6);

            return { startOfWeek, endOfWeek };
        }

        function populateGraphSpentTimeData() {
            graphData.clear();

            var daySpentTimes = {
                "Monday":    { total: 0, count: 0 },
                "Tuesday":   { total: 0, count: 0 },
                "Wednesday": { total: 0, count: 0 },
                "Thursday":  { total: 0, count: 0 },
                "Friday":    { total: 0, count: 0 },
                "Saturday":  { total: 0, count: 0 },
                "Sunday":    { total: 0, count: 0 },
            };

            const today = d.parseDate(d.getCurrentDate());
            const { startOfWeek, endOfWeek } = d.getCurrentWeekRange(today);

            for (var question in sessionObject.successfulImplementations) {
                var data = sessionObject.successfulImplementations[question].spentTime;

                for (var dayData of data.spentTimes) {
                    const day = dayData.day;
                    const dayProblemWasSolved = d.parseDate(dayData.today);

                    if (dayProblemWasSolved >= startOfWeek && dayProblemWasSolved <= endOfWeek) {
                        if (daySpentTimes.hasOwnProperty(day)) {
                            for (const timeEntry of dayData.times) {
                                daySpentTimes[day].total += timeEntry.spentTime;
                                daySpentTimes[day].count += 1;
                            }
                        }
                    }
                }
            }

            for (var day in daySpentTimes) {
                const dayData = daySpentTimes[day];
                const averageTime = dayData.count > 0 ? dayData.total / dayData.count : 0;

                graphData.append({
                    day: day,
                    type: "average",
                    time: averageTime
                });
            }

            speedCanvas.requestPaint();
            statsPage.lastUpdateTime = d.getCurrentTime();
        }

        function populateGraphDetailedSpentTimeData() {
            graphData.clear();

            const daySpentTimes = {
                "Monday": [],
                "Tuesday": [],
                "Wednesday": [],
                "Thursday": [],
                "Friday": [],
                "Saturday": [],
                "Sunday": []
            };

            const today = d.parseDate(d.getCurrentDate());
            const { startOfWeek, endOfWeek } = d.getCurrentWeekRange(today);

            for (const question in sessionObject.successfulImplementations) {
                const data = sessionObject.successfulImplementations[question].spentTime;

                for (const dayData of data.spentTimes) {
                    const day = dayData.day;
                    const dayProblemWasSolved = d.parseDate(dayData.today);

                    if (dayProblemWasSolved >= startOfWeek && dayProblemWasSolved <= endOfWeek) {
                        if (daySpentTimes.hasOwnProperty(day)) {
                            for (const timeEntry of dayData.times) {
                                daySpentTimes[day].push({
                                    questionId: question,
                                    spentTime: timeEntry.spentTime,
                                    hour: timeEntry.time
                                });
                            }
                        }
                    }
                }
            }

            const daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];

            for (const day of daysOfWeek) {
                if (daySpentTimes[day].length === 0) {
                    graphData.append({
                        day: day,
                        questionId: "N/A",
                        type: "individual",
                        time: 0
                    });
                } else {
                    for (const timeData of daySpentTimes[day]) {
                        graphData.append({
                            day: day,
                            questionId: timeData.questionId,
                            type: "individual",
                            time: timeData.spentTime
                        });
                    }
                }
            }

            speedDetailsCanvas.requestPaint();
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
            var today = new Date();
            var hours = today.getHours();
            var minutes = today.getMinutes();

            hours = hours < 10 ? "0" + hours : hours;
            minutes = minutes < 10 ? "0" + minutes : minutes;

            return hours + ":" + minutes;
        }

        function formatTime(seconds) {
            const minutes = String(Math.floor(seconds / 60)).padStart(2, '0');
            const remainingSeconds = String((seconds % 60)).padStart(2, '0');
            return `${minutes}m${remainingSeconds}`;
        }

        function hashString(str) {
            let hash = 0;
            for (let i = 0; i < str.length; i++) {
                hash = (hash << 5) - hash + str.charCodeAt(i);
                hash |= 0; // Convert to 32-bit integer
            }
            return hash;
        }

        function hueToRgb(p, q, t) {
            if (t < 0) t += 1;
            if (t > 1) t -= 1;
            if (t < 1 / 6) return p + (q - p) * 6 * t;
            if (t < 1 / 2) return q;
            if (t < 2 / 3) return p + (q - p) * (2 / 3 - t) * 6;
            return p;
        }

        function hslToHex(hsl) {
            const result = /hsl\((\d+),\s*(\d+)%,\s*(\d+)%\)/.exec(hsl);
            if (!result) {
                throw new Error("Invalid HSL format");
            }

            const h = parseInt(result[1], 10);        // Hue
            const s = parseInt(result[2], 10) / 100;  // Saturation
            const l = parseInt(result[3], 10) / 100;  // Lightness

            let r, g, b;

            if (s === 0) {
                // Achromatic (gray)
                r = g = b = l;
            } else {
                const q = l < 0.5 ? l * (1 + s) : l + s - l * s;
                const p = 2 * l - q;
                r = hueToRgb(p, q, h / 360 + 1 / 3);
                g = hueToRgb(p, q, h / 360);
                b = hueToRgb(p, q, h / 360 - 1 / 3);
            }

            // Convert to hexadecimal and return
            const toHex = (x) => Math.round(x * 255).toString(16).padStart(2, "0");
            return `#${toHex(r)}${toHex(g)}${toHex(b)}`;
        }

        function getColorForQuestion(questionId: string): string{
            if (!questionId) {
                console.error("questionId is undefined");
                return "hsl(0, 0%, 85%)";
            }

            const hash = hashString(questionId);
            const hue = (hash % 360 + 360) % 360;
            const saturation = 50;
            const lightness = 50;

            return `hsl(${hue}, ${saturation}%, ${lightness}%)`;
        }

        function populateQuestionModel() {
            questionModel.clear();
            var questionIndex = {};
            for (var i = 0; i < graphData.count; i++) {
                var point = graphData.get(i);
                if (!point.questionId || point.questionId === "N/A") continue;

                if (!questionIndex[point.questionId]) {
                    questionIndex[point.questionId] = true;
                    var itemColor = d.getColorForQuestion(point.questionId);

                    questionModel.append({ questionId: point.questionId, itemColor: d.hslToHex(itemColor) });
                }
            }
        }
    }

    Text {
        id: title
        anchors.top: parent.top
        anchors.topMargin: 10
        text: {
            if (successCanvas.visible) {
                return "Number of successful implementations per question." 
            } else if (speedCanvas.visible) {
                return "Time (in seconds) spent on average implementing a question."
            } else {
                return "Individual time contribution to overall practice time"
            }
        }
        font.pixelSize: 24
        font.bold: sessionObject.isFontBold
        color: themeObject.textColor
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Text {
        id: details
        anchors.top: title.bottom
        anchors.topMargin: 10
        text: {
            if (successCanvas.visible) { 
                return "Evaluates your performance by considering both the success rate and the frequency of problems solved." 
            } else if (speedCanvas.visible) {
                return "Monitors the time (in seconds) spent on average when solving any questions on that day."
            } else {
                return "Monitors the individual time contribution to overall practice time measured in minutes and seconds"
            }
        }
        font.pixelSize: 14
        font.bold: sessionObject.isFontBold
        color: themeObject.textColor
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Text {
        id: description
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
        enabled: !detailsButtonCheckedState

        onToggled: {
            speedCanvas.visible ? d.populateGraphSpentTimeData() : d.populateGraphGaussianData()
        }
    }

    ListModel {
        id: questionModel
    }

    ListModel {
        id: graphData
    }

    Canvas {
        id: successCanvas
        anchors.fill: parent
        anchors.margins: 100
        visible: control.checked && !detailsButtonCheckedState

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

            var yAxisMax = Math.ceil(maxScore / 10) * 10 * 2;
            if (yAxisMax === 0) yAxisMax = 20;

            // Draw the axes
            ctx.beginPath();
            ctx.lineWidth = 1;
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
                ctx.fillText(((gridLines - i) * (yAxisMax / gridLines)).toString(), graphWidth + 40, y + 4);
            }

            // Adjust bar width and spacing
            var barWidth = (graphWidth / graphData.count) * 0.3;  // Reduce bar width to 50% of each segment
            var segmentWidth = graphWidth / graphData.count;
            var cornerRadius = 5;  // Set the radius for the rounded corners

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
            ctx.fillText("goal 5", successCanvas.width - 2 * padding, yPos - 4);
        }
    }

    Canvas {
        id: speedCanvas
        anchors.fill: parent
        anchors.margins: 100
        visible: !control.checked && !detailsButtonCheckedState

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
            ctx.lineWidth = 1;
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
                ctx.fillText(d.formatTime((gridLines - i) * (yAxisMax / gridLines)), graphWidth + 40, y + 4);
            }

            var barWidth = (graphWidth / graphData.count) * 0.3;
            var segmentWidth = graphWidth / graphData.count;
            var cornerRadius = 5; // Set the radius for the rounded corners

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
                var yPos = speedCanvas.height - padding - barHeight - 5;
                ctx.fillStyle = themeObject.textColor;
                ctx.font = "12px Arial";
                ctx.save();
                ctx.translate(xPos, yPos);
                var textWidth = d.formatTime(point.time).length
                ctx.fillText(point.time.toFixed(2, 0).padStart(2, '0'), 0, 0)
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

    Canvas {
        id: speedDetailsCanvas
        anchors.fill: parent
        anchors.margins: 100
        visible: detailsButtonCheckedState

        onPaint: {
            var ctx = speedDetailsCanvas.getContext("2d");
            ctx.clearRect(0, 0, speedDetailsCanvas.width, speedDetailsCanvas.height);

            var padding = 40;
            var graphWidth = speedDetailsCanvas.width - padding * 2;
            var graphHeight = speedDetailsCanvas.height - padding * 2;

            var maxTime = 0;
            for (var i = 0; i < graphData.count; i++) {
                var point = graphData.get(i);
                maxTime += point.time;  // Add up all times for stacked visualization
            }

            var yAxisMax = Math.ceil(maxTime / 10) * 10;
            if (yAxisMax === 0) yAxisMax = 10;

            // Draw the axes
            ctx.beginPath();
            ctx.lineWidth = 1;
            ctx.strokeStyle = "#777777";
            ctx.moveTo(padding, padding);
            ctx.lineTo(padding, speedDetailsCanvas.height - padding);
            ctx.lineTo(speedDetailsCanvas.width - padding, speedDetailsCanvas.height - padding);
            ctx.stroke();

            // Draw y-axis grid lines
            var gridLines = 5;
            ctx.lineWidth = 0.5;
            ctx.strokeStyle = "#cccccc";
            for (var i = 1; i <= gridLines; i++) {
                var y = padding + (graphHeight / gridLines) * i;
                ctx.beginPath();
                ctx.moveTo(padding, y);
                ctx.lineTo(speedDetailsCanvas.width - padding, y);
                ctx.stroke();

                ctx.fillStyle = "#777777";
                ctx.font = "12px Arial";
                ctx.fillText(d.formatTime((gridLines - i) * (yAxisMax / gridLines)).toString(), graphWidth + 40, y + 4);
            }

            var segmentWidth = graphWidth / 7;  // Assume 7 days for simplicity
            var barWidth = segmentWidth * 0.3;
            var cornerRadius = 5;

            // Helper function to draw a rounded rectangle
            function drawTopRoundedRect(ctx, x, y, width, height, radius, isTopBar) {
                if (height === 0) return;

                ctx.beginPath();
                if (isTopBar) {
                    // Apply rounded corners only for the top of the bar
                    ctx.moveTo(x, y + height);
                    ctx.lineTo(x, y + radius);
                    ctx.quadraticCurveTo(x, y, x + radius, y);
                    ctx.lineTo(x + width - radius, y);
                    ctx.quadraticCurveTo(x + width, y, x + width, y + radius);
                    ctx.lineTo(x + width, y + height);
                } else {
                    // Draw a rectangle with square corners
                    ctx.rect(x, y, width, height);
                }
                ctx.closePath();
            }

            var dayBarCounts = {};
            for (var i = 0; i < graphData.count; i++) {
                var day = graphData.get(i).day;
                dayBarCounts[day] = (dayBarCounts[day] || 0) + 1;
            }

            // Draw each day's stacked bar
            var dayIndex = {};

            for (var i = 0; i < graphData.count; i++) {
                var point = graphData.get(i);
                var day = point.day;

                // Initialize stacking information if not already set for the day
                if (!dayIndex[day]) {
                    dayIndex[day] = {
                        xPos: padding + (Object.keys(dayIndex).length * segmentWidth) + (segmentWidth - barWidth) / 2,
                        currentHeight: 0,
                        barCount: 0
                    };
                }

                var xPos = dayIndex[day].xPos;
                var barHeight = (point.time / yAxisMax) * graphHeight;
                var yPos = speedDetailsCanvas.height - padding - barHeight - dayIndex[day].currentHeight;

                ctx.save();
                
                if (!point.questionId || point.questionId === "N/A") continue;

                // Set color dynamically based on index
                var barColor = d.getColorForQuestion(point.questionId);
                ctx.fillStyle = barColor;
                ctx.strokeStyle = barColor;

                // Check if this is the top-most bar in the stack
                var isTopBar = (dayIndex[day].barCount > dayBarCounts[day] - 2);

                // Draw rounded only for the top bar
                drawTopRoundedRect(ctx, xPos, yPos, barWidth, barHeight, cornerRadius, isTopBar);
                
                ctx.fill();
                ctx.stroke();
                ctx.restore();

                // Update cumulative height and bar count for the day
                dayIndex[day].currentHeight += barHeight;
                dayIndex[day].barCount += 1;
            }

            // Draw day labels at the bottom of each column
            var dayNames = Object.keys(dayIndex);
            for (var i = 0; i < dayNames.length; i++) {
                var day = dayNames[i];
                var xPos = dayIndex[day].xPos;
                var yPos = speedDetailsCanvas.height - 25;
                ctx.fillStyle = themeObject.textColor;
                ctx.font = "12px Arial";
                ctx.save();
                ctx.translate(xPos, yPos);
                ctx.fillText(day, 0, 0);
                ctx.restore();
            }
        }
    }

    Column {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 20

        ListView {
            id: questionListView
            width: speedDetailsCanvas.width
            height: 20
            orientation: Qt.Horizontal
            spacing: 10

            anchors.bottom: updatedTime.top
            anchors.bottomMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            clip: true
            anchors.horizontalCenterOffset: 20

            model: questionModel

            Component.onCompleted: {
                if (dataReady && graphData.count > 0) {
                    d.populateQuestionModel();
                }
            }

            delegate: Rectangle {
                width: questionId.width + 30
                height: 20
                color: "transparent"
                radius: 5
                anchors.horizontalCenter: root.horizontalCenter

                RowLayout {
                    anchors.centerIn: parent
                    spacing: 20

                    Rectangle {
                        width: 10
                        height: 10
                        color: model.itemColor
                        radius: 3
                    }

                    Text {
                        id: questionId
                        text: model.questionId
                        font.pointSize: 12
                        color: themeObject.textColor
                        elide: Text.ElideRight
                        anchors.centerIn: parent
                    }
                }
            }
        }

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

            Button {
                id: detailsButton
                enabled: !control.checked
                text: qsTr("View details")
                onClicked: {
                    detailsButtonCheckedState = !detailsButtonCheckedState

                    if (detailsButtonCheckedState) {
                        d.populateGraphDetailedSpentTimeData()
                    } else {
                        d.populateGraphSpentTimeData()
                    }
                }
                Layout.alignment: Qt.AlignHCenter
                width: 200 
                height: 50
                font.bold: sessionObject.isFontBold

                contentItem: Text {
                    text: detailsButton.text
                    font: detailsButton.font
                    opacity: enabled ? 1.0 : 0.3
                    color: detailsButtonCheckedState ? "#F7F7F7" : themeObject.textColor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                background: Rectangle {
                    radius: 10
                    border.width: 1
                    border.color: themeObject.buttonBorderColor
                    color: {
                        return !detailsButtonCheckedState ? themeObject.buttonColor : themeObject.buttonActionColor
                    }
                }
            }
        }
    }
}
