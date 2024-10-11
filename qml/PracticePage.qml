import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
// import QtWebView 1.1
import "handler.js" as QuestionsHandler

import "bfs-recursive.js" as BfsRecursive
import "dfs-recursive.js" as DfsRecursive
import "bfs-iterative.js" as BfsIterative
import "dsu.js" as Dsu
import "dfs-iterative.js" as DfsIterative
import "dijkstra.js" as Dijkstra
import "binary-search.js" as BinarySearch
import "kmp.js" as Kmp
import "kadane.js" as Kadane

Rectangle {
    id: root

    anchors.centerIn: parent
    Layout.fillWidth: true
    Layout.fillHeight: true

    property int timeLimit: 300
    property int timerValue: timeLimit
    property string solution: ""
    property int currentQuestionIndex: 0
    property string userAnswer: ""
    property bool quizComplete: false
    property int correctAnswers: 0
    property var visitedNumbers: []
    property bool submitted: false
    property bool isCurrentAnswerCorrect: false
    property string currentLanguage: "C++"
    property bool showSolution: true
    property string submittedAnswer: ""
    property string expectedAnswer: ""
    property var questionsData: []
    property string aiComment: ""
    property string api_key: ""

    color: themeObject.backgroundColor

    Component.onCompleted: {
        questionsData = BfsRecursive.bfsQuestions
            .concat(DfsRecursive.dfsQuestions)
            .concat(BfsIterative.bfsQuestions)
            .concat(Dsu.DsuQuestions)
            .concat(DfsIterative.dfsQuestions)
            .concat(Dijkstra.dijkstraQuestions)
            .concat(BinarySearch.binarySearchQuestions)
            .concat(Kmp.kmpQuestions)
            .concat(Kadane.kadaneQuestions)
        console.log("Total questions loaded: ", questionsData.length);
    }

    Rectangle {
        id: practicePage
        anchors.centerIn: parent
        height: parent.height - 20
        width: parent.width - 20
        color: themeObject.backgroundColor

        QtObject {
            id: d

            function pauseStartTimer() {
                if (countdownTimer.running) {
                    countdownTimer.stop()
                } else {
                    countdownTimer.start()
                }
            }

            function updateLanguage(currentLanguage) {
                answerInput.placeholderText = QuestionsHandler.getQuestionPlaceHolder(questionsData, currentLanguage, currentQuestionIndex)
            }

            function submitPrompt(prompt) {
                var url = "https://api-inference.huggingface.co/models/gpt2";
                var jsonData = {
                    "inputs": prompt
                };

                var xhr = new XMLHttpRequest();
                xhr.open("POST", url, true);
                xhr.setRequestHeader("Content-Type", "application/json");
                xhr.setRequestHeader("Authorization", "Bearer " + api_key);

                xhr.onreadystatechange = function() {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        if (xhr.status === 200) {
                            var response = JSON.parse(xhr.responseText);
                            root.aiComment = response[0].generated_text;
                        } else {
                            console.log("Error: ", xhr.statusText);
                        }
                    }
                };

                xhr.send(JSON.stringify(jsonData));
            }

            function validateAnswer(language) {
                countdownTimer.stop()
                expectedAnswer = QuestionsHandler.getAnswer(questionsData, language, currentQuestionIndex).trim()

                root.submittedAnswer = userAnswer

                var prompt = "\nWhat is a brief difference between \n\n ```\n" + expectedAnswer + "\n```\n\n and \n\n```\n" + userAnswer + "\n```"
                // submitPrompt(prompt);

                if (currentQuestionIndex < QuestionsHandler.getTotalQuestions(questionsData)) {
                    const result = QuestionsHandler.getLevenshteinDistance(userAnswer.trim(), expectedAnswer)

                    if (result.similarityStatus === "Highly Similar") {
                        resultsModel.append({ similarity: "Highly Similar", id: currentQuestionIndex + 1 })
                        correctAnswers++
                        isCurrentAnswerCorrect = true
                    } else if (result.similarityStatus === "Moderately Similar") {
                        resultsModel.append({ similarity: "Moderately Similar", id: currentQuestionIndex + 1 })
                        correctAnswers++
                        isCurrentAnswerCorrect = true
                    } else {
                        answerInput.text = expectedAnswer
                        answerInput.readOnly = true
                        resultsModel.append({ similarity: "Not Similar", id: currentQuestionIndex + 1 })
                        isCurrentAnswerCorrect = false
                    }

                    submitted = true
                    nextButton.enabled = true
                    clock.enabled = false
                    countdownTimer.stop()
                }
            }

            function showSolution() {
                answerInput.text = root.expectedAnswer // + "\n" + root.aiComment
            }

            function showSubmission() {
                answerInput.text = root.submittedAnswer
            }

            function getRandomInt(min, max) {
                var randomNumber = 0

                do {
                    randomNumber = Math.floor(Math.random() * (max - min + 1)) + min;
                } while (visitedNumbers.includes(randomNumber))

                return randomNumber
            }

            function goToQuestion(questionIndex) {
                var total = QuestionsHandler.getTotalQuestions(questionsData)

                if (isCurrentAnswerCorrect) {
                    visitedNumbers.push(currentQuestionIndex)
                }

                if (visitedNumbers.length >= total) {
                    resultText.text = ""
                    quizComplete = true
                    resultText.enabled = false
                    return
                }

                submitted = false
                currentQuestionIndex = questionIndex
                loadNextQuestion()
            }

            function goToNextQuestion() {
                var total = QuestionsHandler.getTotalQuestions(questionsData)

                if (isCurrentAnswerCorrect) {
                    visitedNumbers.push(currentQuestionIndex)
                }

                if (visitedNumbers.length >= total) {
                    resultText.text = ""
                    quizComplete = true
                    resultText.enabled = false
                    return
                }

                submitted = false
                currentQuestionIndex = getRandomInt(0, total - 1)
                loadNextQuestion()
            }

            function loadNextQuestion() {
                questionLabel.text = (currentQuestionIndex + 1) + ". Implement a " + QuestionsHandler.getQuestion(questionsData, currentQuestionIndex)
                userAnswer = ""
                answerInput.text = ""
                timerValue = timeLimit
                countdownTimer.start()
                resultText.enabled = false
                answerInput.readOnly = false
                isCurrentAnswerCorrect = false
            }

            function resetTest() {
                resultText.enabled = false
                timerValue = timeLimit
                countdownTimer.start()
                quizComplete = false
                resultsModel.clear()
                visitedNumbers = []
                correctAnswers = 0
                currentQuestionIndex = 0
                questionLabel.text = (currentQuestionIndex + 1) + ". Implement a " + QuestionsHandler.getQuestion(questionsData, currentQuestionIndex)
                answerInput.text = ""
                answerInput.readOnly = false
                clock.enabled = true
                isCurrentAnswerCorrect = false
            }
        }

        ListModel {
            id: resultsModel
        }

        Timer {
            id: countdownTimer
            interval: 1000
            running: true
            repeat: true
            onTriggered: {
                if (timerValue > 0) {
                    timerValue--
                } else {
                    d.validateAnswer(root.currentLanguage)
                }
            }
        }

        ScrollView {
            width: parent.width
            height: parent.height
            anchors.centerIn: parent

            ColumnLayout {
                anchors.fill: parent
                spacing: 20

                Item {
                    width: parent.width
                    height: 40

                    Row {
                        spacing: 10
                        anchors.fill: parent
                        visible: !quizComplete

                        Repeater {
                            model: resultsModel
                            Rectangle {
                                width: 30
                                height: 30
                                radius: 15
                                color: "transparent"

                                Text {
                                    id: questionLabel
                                    text: model.similarity === "Highly Similar" 
                                    ? "👏"
                                    : model.similarity === "Moderately Similar" 
                                    ? "👍"
                                    : "👎"
                                    font.pixelSize: 24
                                    color: themeObject.textColor
                                    font.bold: true
                                    anchors.centerIn: parent
                                }
                            }
                        }
                    }
                }

                Text {
                    id: questionLabel
                    text: (currentQuestionIndex + 1) +  ". Implement a " + QuestionsHandler.getQuestion(questionsData, currentQuestionIndex)
                    font.pixelSize: 14
                    font.bold: true
                    color: themeObject.textColor
                    visible: !quizComplete
                }

                Text {
                    id: correctQuestionSummary
                    text: {
                        var celebrate = ""
                        if ((1.0 * correctAnswers) / (1.0 * QuestionsHandler.getTotalQuestions(questionsData)) >= 0.75) {
                            celebrate = " 🏆 "
                        }
                        return celebrate + "Score " + correctAnswers + "/" + QuestionsHandler.getTotalQuestions(questionsData) + " questions" + celebrate
                    }
                    font.pixelSize: 24
                    Layout.alignment: Qt.AlignHCenter
                    color: themeObject.textColor
                    visible: quizComplete
                }

                Text {
                    id: endOfQuizText
                    text: "No more questions"
                    font.pixelSize: 14
                    Layout.alignment: Qt.AlignHCenter
                    color: themeObject.textColor
                    visible: quizComplete
                }

                Text {
                    id: endOfQuizImage
                    text: "🦔"
                    font.pixelSize: 100
                    Layout.alignment: Qt.AlignHCenter
                    visible: quizComplete
                }

                RowLayout {
                    Rectangle {
                        id: questionDifficulty
                        height: 25
                        width: 70
                        color: {
                            if (QuestionsHandler.getQuestionDifficulty(questionsData, currentQuestionIndex) === "Easy") {
                                return themeObject.buttonEasyColor
                            } else if (QuestionsHandler.getQuestionDifficulty(questionsData, currentQuestionIndex) === "Medium") {
                                return themeObject.buttonMediumColor
                            }
                            return themeObject.buttonHardColor
                        }
                        radius: 15
                        visible: !quizComplete

                        Text {
                            text: QuestionsHandler.getQuestionDifficulty(questionsData, currentQuestionIndex)
                            font.pixelSize: 14
                            font.bold: true
                            anchors.centerIn: parent
                            color: themeObject.textColor
                        }
                    }

                    ComboBox {
                        id: languageComboBox
                        model: [ "C++", "Go" ]
                        currentIndex: 0

                        MouseArea {
                            id: comboBoxMouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            acceptedButtons: Qt.NoButton
                        }

                        background: Rectangle {
                            radius: 15
                            color: comboBoxMouseArea.containsMouse ? themeObject.buttonHoveredColor : themeObject.buttonColor
                            border.color: themeObject.buttonBorderColor
                            border.width: 1
                        }

                        contentItem: Text {
                            text: languageComboBox.currentText
                            font: languageComboBox.font
                            elide: Text.ElideRight
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            anchors.fill: parent
                            anchors.margins: 10
                            color: themeObject.textColor
                        }

                        Component.onCompleted: {
                            var maxText = model.reduce(function(a, b) { 
                                return a.length > b.length ? a : b; 
                            });
                            var metrics = Qt.fontMetrics(font);
                            width = metrics.width(maxText) + 30;
                        }

                        onActivated: {
                            currentLanguage = languageComboBox.currentText
                            d.updateLanguage(currentLanguage)
                        }
                    }

                    Switch {
                        id: themeToggle
                        font.bold: true
                        text: themeObject.theme === "light" ? "Light Theme" : "Dark Theme"
                        checked: themeObject.theme === "dark"
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

                TextArea {
                    id: answerInput
                    Layout.fillWidth: true
                    height: 200
                    readOnly: submitted
                    placeholderText: QuestionsHandler.getQuestionPlaceHolder(questionsData, currentLanguage, currentQuestionIndex)
                    font.family: "Courier New"
                    font.pixelSize: 14
                    font.bold: true
                    color: themeObject.textColor
                    padding: 10
                    antialiasing: true
                    wrapMode: Text.Wrap
                    visible: !quizComplete
                    background: Rectangle {
                        color: themeObject.textAreaBackgroundColor
                        border.width: 1
                        border.color: themeObject.textAreaBorderColor
                        radius: 15
                    }
                    onTextChanged: {
                        userAnswer = text
                        if (!countdownTimer.running && !submitted) {
                            countdownTimer.start()
                        }
                    }

                    Rectangle {
                        id: clock
                        height: 25
                        width: 170
                        opacity: countdownTimer.running ? 1 : 0.5
                        color: {
                            if (timerValue < 30) {
                                    return themeObject.buttonHardColor
                                } else if (timerValue < 60) {
                                    return themeObject.buttonMediumColor
                                } else {
                                    return themeObject.backgroundColor
                                }
                            }
                        radius: 15
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        anchors.margins: 10

                        Text {
                            text: (visitedNumbers.length + 1) + "/" + QuestionsHandler.getTotalQuestions(questionsData) + " 🕦 Time left: " + timerValue + "s"
                            Layout.alignment: Qt.AlignRight
                            font.pixelSize: 14
                            anchors.centerIn: parent
                            font.bold: true
                            color: themeObject.textColor
                        }
                    }

                    Rectangle {
                        id: viewSubmission
                        
                        height: 25
                        width: viewSubmissionText.width + 20
                        color: themeObject.buttonMediumColor
                        opacity: submitted ? 1 : 0.5
                        enabled: submitted
                        radius: 15
                        anchors.top: parent.top
                        anchors.right: parent.right
                        anchors.margins: 10

                        Text {
                            id: viewSubmissionText
                            text: root.showSolution ? "View your submission" : "View solution"
                            anchors.centerIn: parent
                            font.pixelSize: 14
                            font.bold: true
                            color: themeObject.textColor
                        }

                        MouseArea {
                            anchors.fill: parent
                            
                            onClicked: {
                                root.showSolution = !root.showSolution
                                if (root.showSolution) {
                                    d.showSolution()
                                } else {
                                    d.showSubmission()
                                }
                            }
                        }
                    }
                }

                RowLayout {
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

                    Button {
                        id: validate
                        text: qsTr("Submit")
                        onClicked: d.validateAnswer(currentLanguage)
                        Layout.alignment: Qt.AlignRight
                        visible: !quizComplete
                        enabled: !submitted && answerInput.length > 0
                        width: 200
                        height: 50

                        contentItem: Text {
                            text: validate.text
                            font: validate.font
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
                                return validate.hovered ? themeObject.buttonHoveredColor : themeObject.buttonColor
                            }
                        }
                    }

                    Button {
                        id: pause
                        text: countdownTimer.running ? qsTr("Pause timer") : qsTr("Resume timer")
                        onClicked: d.pauseStartTimer()
                        Layout.alignment: Qt.AlignRight
                        visible: !submitted
                        width: 200
                        height: 50

                        contentItem: Text {
                            text: pause.text
                            font: pause.font
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
                                return pause.hovered ? themeObject.buttonHoveredColor : themeObject.buttonColor
                            }
                        }
                    }

                    Button {
                        id: redo
                        text: qsTr("Retry")
                        onClicked: d.goToQuestion(currentQuestionIndex)
                        Layout.alignment: Qt.AlignRight
                        visible: !quizComplete
                        width: 200
                        height: 50

                        contentItem: Text {
                            text: redo.text
                            font: redo.font
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
                                return redo.hovered ? themeObject.buttonHoveredColor : themeObject.buttonColor
                            }
                        }
                    }

                    Button {
                        id: restartButton
                        text: "Restart Quiz"
                        visible: quizComplete
                        width: 200
                        height: 50

                        onClicked: {
                            d.resetTest()
                        }

                        contentItem: Text {
                            text: restartButton.text
                            font: restartButton.font
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
                                return restartButton.hovered ? themeObject.buttonHoveredColor : themeObject.buttonColor
                            }
                        }
                    }

                    Button {
                        id: nextButton
                        text: "Skip"
                        visible: !quizComplete
                        width: 200
                        height: 50
                        onClicked: {
                            d.goToNextQuestion()
                            d.updateLanguage(currentLanguage)
                        }

                        contentItem: Text {
                            text: nextButton.text
                            font: nextButton.font
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
                                return nextButton.hovered ? themeObject.buttonHoveredColor : themeObject.buttonColor
                            }
                        }
                    }

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

                Rectangle {
                    id: ads
                    width: parent.width - 20
                    height: 150
                    color: "transparent"
                    visible: false

                    // WebView {
                    //     id: adView
                    //     anchors.fill: parent
                    //     url: Qt.resolvedUrl("adsense-ad.html")
                    //     onLoadingChanged: {
                    //         if (loadRequest.status === WebView.LoadSucceededStatus) {
                    //             console.log("Ad loaded successfully");
                    //         } else if (loadRequest.status === WebView.LoadFailedStatus) {
                    //             console.error("Failed to load the ad");
                    //         }
                    //     }
                    // }
                }

                Text {
                    id: resultText
                    font.pixelSize: 14
                    color: themeObject.textColor
                    visible: false
                }
            }
        }
    }
}
