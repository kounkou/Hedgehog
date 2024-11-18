import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
// import QtWebView 1.1
import Hedgehog 1.0

import "handler.js" as QuestionsHandler

import "bfs-recursive.js" as BfsRecursive
import "dfs-recursive.js" as DfsRecursive
import "bfs-iterative.js" as BfsIterative
import "dsu.js" as Dsu
import "dfs-iterative.js" as DfsIterative
import "dijkstra.js" as Dijkstra
import "kadane.js" as Kadane

import "kmp.js" as Kmp
import "lcp.js" as LCP
import "rabin-karp.js" as RabinKarp
import "split-sentence.js" as SplitSentence

import "binary-search.js" as BinarySearch
import "linear-search.js" as LinearSearch
import "jump-search.js" as JumpSearch
import "interpolation-search.js" as InterpolationSearch

import "line-intersection.js" as LineIntersection
import "area-triangle-heron.js" as AreaTriangleHeron
import "convex-hull.js" as ConvexHull
import "merge-interval.js" as MergeIntervals
import "insert-interval.js" as InsertInterval
import "min-meeting-room.js" as MinMeetingRoom
import "trie.js" as Trie
import "fractional-knapsack.js" as FractionalKnapsack
import "sieve.js" as Sieve
import "gcd.js" as GCD
import "fast-exponentiation.js" as FastExponentiation
import "insert-at-end.js" as InsertAtEnd
import "remove-element.js" as RemoveElement
import "ancestor.js" as Ancestor
import "factorial.js" as Factorial
import "heap-sort.js" as HeapSort
import "insert-heap.js" as InsertHeap
import "check-power-of-two.js" as CheckPowerOfTwo
import "count-set-bit.js" as CountSetBit
import "reverse-bits.js" as ReverseBits
import "max-sub-array.js" as MaxSubArray
import "topological-sorting.js" as TopologicalSorting
import "backtracking.js" as BackTracking
import "lazy-propagation.js" as LazyPropag
import "range-sum-queries.js" as RangeSumQueries

import "unique-paths.js" as UniquePaths
import "count-permutations.js" as CountPermutations
import "generate-subsets.js" as GenerateSubsets
import "count-combinations.js" as CountCombinations 

import "merge-sort.js" as MergeSort
import "quick-sort.js" as QuickSort

import "load-balancer-types.js" as LoadBalancing
import "cache-types.js" as Cache

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
    property bool submitted: false
    property bool isCurrentAnswerCorrect: false
    property string currentLanguage: "C++"
    property bool showSolution: true
    property string submittedAnswer: ""
    property string expectedAnswer: ""
    property var questionsData: []
    property string aiComment: ""
    property var localVisitedNumbers: ({})
    
    property var session: null

    color: themeObject.backgroundColor

    Component.onCompleted: {
        // Organize questions into categories
        var allQuestionsData = {
            Programming: [
                ...BfsRecursive.question,
                ...DfsRecursive.question,
                ...BfsIterative.question,
                ...Dsu.question,
                ...Dijkstra.question,
                ...Kadane.question,
                ...LineIntersection.question,
                ...AreaTriangleHeron.question,
                ...ConvexHull.question,
                ...MergeIntervals.question,
                ...InsertInterval.question,
                ...MinMeetingRoom.question,
                ...Kmp.question,
                ...LCP.question,
                ...RabinKarp.question,
                ...SplitSentence.question,
                ...BinarySearch.question,
                ...JumpSearch.question,
                ...InterpolationSearch.question,
                ...Trie.question,
                ...FractionalKnapsack.question,
                ...InsertAtEnd.question,
                ...RemoveElement.question,
                ...Ancestor.question,
                ...Factorial.question,
                ...Sieve.question,
                ...GCD.question,
                ...FastExponentiation.question,
                ...HeapSort.question,
                ...InsertHeap.question,
                ...MaxSubArray.question,
                ...CheckPowerOfTwo.question,
                ...CountSetBit.question,
                ...ReverseBits.question,
                ...TopologicalSorting.question,
                ...BackTracking.question,
                ...LazyPropag.question,
                ...RangeSumQueries.question,
                ...UniquePaths.question,
                ...CountPermutations.question,
                ...GenerateSubsets.question,
                ...CountCombinations.question,
                ...MergeSort.question,
                ...QuickSort.question,
                ...LinearSearch.question
            ],
            SystemDesign: [
                ...LoadBalancing.question,
                ...Cache.question
            ]
        };

        // Filter questions based on selected categories
        var selectedCategories = sessionObject.selectedCategories[sessionObject.topic] || {};

        if (selectedCategories.length > 0) {
            questionsData = allQuestionsData.Programming.concat(allQuestionsData.SystemDesign).filter(function(question) {
                return selectedCategories.includes(question.category);
            });
        } else {
            questionsData = allQuestionsData.Programming.concat(allQuestionsData.SystemDesign);
        }

        // Set questions and navigate to the next question
        sessionObject.selectedCategories[sessionObject.topic] = selectedCategories;
        d.goToNextQuestion();
    }

    Rectangle {
        id: practicePage
        anchors.centerIn: parent
        height: parent.height - 20
        width: parent.width - 20
        color: themeObject.backgroundColor

        QtObject {
            id: d

            function openContextMenu(x, y) {
                console.log("---> in openContextMenu")
                contextMenu.popup(x, y)
            }

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
                var url = "https://api.openai.com/v1/chat/completions";
                var jsonData = {
                    "model": "gpt-3.5-turbo",
                    "messages": [
                        {
                            "role": "system",
                            "content": "If the code snippet \n" + prompt + "\n matches with \n" + QuestionsHandler.getAnswer(questionsData, currentLanguage, currentQuestionIndex).trim() + 
                            ", answer briefly with 'Highly Similar', 'Moderately Similar' or 'Not Similar' in html format without further explanation. If the code doesn't match, as a Senior Software engineer, provide explanation how to implement " + 
                            QuestionsHandler.getQuestion(questionsData, currentQuestionIndex) + " in " + currentLanguage
                        }
                    ],
                    "temperature": 0.7
                };

                // console.debug("---> ", jsonData.messages[0].content)

                var xhr = new XMLHttpRequest();
                xhr.open("POST", url, true);
                xhr.setRequestHeader("Content-Type", "application/json");
                xhr.setRequestHeader("Authorization", "Bearer " + sessionObject.apiKey);

                xhr.onreadystatechange = function() {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        if (xhr.status === 200) {
                            var response = JSON.parse(xhr.responseText);
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

                if (sessionObject.apiKey.length > 0) {
                    submitPrompt(userAnswer);
                }

                sessionObject.attempted += 1

                if (currentQuestionIndex < QuestionsHandler.getTotalQuestions(questionsData)) {
                    let result = {}

                    if (aiComment.length === 0) {
                        // console.debug("---> LLM not available")

                        result = QuestionsHandler.getLevenshteinDistance(userAnswer.trim(), expectedAnswer)
                    } else {
                        // console.debug("---> LLM available!")

                        if (aiComment.includes("Highly Similar")) {
                            result.similarityStatus = "Highly Similar"
                        } else if (aiComment.includes("Moderately Similar")) {
                            result.similarityStatus = "Moderately Similar"
                        } else {
                            result.similarityStatus = "Not Similar"
                        }
                    }

                    if (result.similarityStatus === "Highly Similar" || result.similarityStatus === "Moderately Similar") {
                        resultsModel.append({
                            similarity: result.similarityStatus, 
                            id: currentQuestionIndex + 1 
                        });
                        correctAnswers++;
                        isCurrentAnswerCorrect = true;
                        sessionObject.algorithmAttempt(
                            QuestionsHandler.getQuestionID(questionsData, currentQuestionIndex), 
                            true,
                            timeLimit - timerValue);
                        sessionObject.todayVisitedNumbers += 1;
                    } else {
                        answerInput.text = expectedAnswer;
                        answerInput.readOnly = true;
                        resultsModel.append({
                            similarity: "Not Similar", 
                            id: currentQuestionIndex + 1 
                        });
                        isCurrentAnswerCorrect = false;
                        sessionObject.algorithmAttempt(
                            QuestionsHandler.getQuestionID(questionsData, currentQuestionIndex), 
                            false,
                            timeLimit - timerValue);
                    }

                    submitted = true
                    nextButton.enabled = true
                    clock.enabled = false
                    countdownTimer.stop()
                }
            }

            function showSolution() {
                answerInput.text = root.expectedAnswer
                aiOutput.text = root.aiComment
            }

            function showSubmission() {
                answerInput.text = root.submittedAnswer
            }

            function getRandomInt(min, max) {
                var randomNumber = 0

                do {
                    randomNumber = Math.floor(Math.random() * (max - min + 1)) + min;
                } while (sessionObject.visitedNumbers && sessionObject.visitedNumbers[sessionObject.topic] && sessionObject.visitedNumbers[sessionObject.topic].includes(randomNumber))

                return randomNumber
            }

            function goToQuestion(questionIndex) {
                var total = QuestionsHandler.getTotalQuestions(questionsData);
                let questionID = QuestionsHandler.getQuestionID(questionsData, currentQuestionIndex);

                // Handle if the current answer is correct
                if (isCurrentAnswerCorrect) {
                    let successfulImplementations = sessionObject.successfulImplementations[questionID];
                    if (successfulImplementations && successfulImplementations.count >= 5) {
                        if (sessionObject.visitedNumbers && sessionObject.visitedNumbers[sessionObject.topic]) {
                            if (!sessionObject.visitedNumbers[sessionObject.topic].includes(questionID)) {
                                sessionObject.visitedNumbers[sessionObject.topic].push(questionID);
                            }
                        } else {
                            if (!localVisitedNumbers[sessionObject.topic]) {
                                localVisitedNumbers[sessionObject.topic] = [];
                            }
                            localVisitedNumbers[sessionObject.topic].push(questionID);
                        }
                        sessionObject.saveSession();
                    }
                }

                // Check if all questions have been visited
                if (
                    localVisitedNumbers[sessionObject.topic] &&
                    localVisitedNumbers[sessionObject.topic].length >= total
                ) {
                    resultText.text = "";
                    quizComplete = true;
                    resultText.enabled = false;
                    return;
                }

                // Prepare for the next question
                submitted = false;
                currentQuestionIndex = questionIndex;
                loadNextQuestion();
            }

            function goToNextQuestion() {
                var total = QuestionsHandler.getTotalQuestions(questionsData);
                let questionID = QuestionsHandler.getQuestionID(questionsData, currentQuestionIndex);

                if (isCurrentAnswerCorrect) {
                    // Check if the entry exists and meets the condition
                    if (sessionObject.successfulImplementations[questionID] && sessionObject.successfulImplementations[questionID].count >= 5) {

                        // Ensure `visitedNumbers` and the topic array are initialized
                        if (!sessionObject.visitedNumbers) {
                            sessionObject.visitedNumbers = {};
                        }

                        if (!sessionObject.visitedNumbers[sessionObject.topic]) {
                            sessionObject.visitedNumbers[sessionObject.topic] = [];
                        }

                        // Check and add `questionID` if not already present
                        if (!sessionObject.visitedNumbers[sessionObject.topic].includes(questionID)) {
                            sessionObject.visitedNumbers[sessionObject.topic].push(questionID);
                        }

                        // Ensure localVisitedNumbers follows the same structure
                        if (!localVisitedNumbers[sessionObject.topic]) {
                            localVisitedNumbers[sessionObject.topic] = [];
                        }

                        if (!localVisitedNumbers[sessionObject.topic].includes(questionID)) {
                            localVisitedNumbers[sessionObject.topic].push(questionID);
                        }

                        // Save the session after updates
                        sessionObject.saveSession();
                    }
                }

                // Check if all questions have been visited
                if (
                    localVisitedNumbers && localVisitedNumbers[sessionObject.topic] && localVisitedNumbers[sessionObject.topic].length >= total
                ) {
                    resultText.text = "";
                    quizComplete = true;
                    resultText.enabled = false;
                    return;
                }

                // Prepare for the next question
                answerInput.visible = true;
                submitted = false;
                currentQuestionIndex = getRandomInt(0, total - 1);
                loadNextQuestion();
            }

            function handleIdentation(event) {
                if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                    let cursorPos = answerInput.cursorPosition
                    let text = answerInput.text
                    let currentLineStart = text.lastIndexOf("\n", cursorPos - 1) + 1
                    let currentLineEnd = cursorPos
                    let currentLineText = text.substring(currentLineStart, currentLineEnd).trim()
                    let indentation = text.substring(currentLineStart, currentLineEnd).match(/^\s*/)[0]

                    if (currentLineText && currentLineText.slice(-1) !== '{' && currentLineText.slice(-1) !== '}') {
                        d.insertText("\n" + indentation)
                    } else if (currentLineText.slice(-1) === '{') {
                        d.insertText("\n" + indentation + "    ")
                    } else if (currentLineText.slice(-1) === '}') {
                        let reducedIndentation = indentation.substring(0, Math.max(0, indentation.length - 4))
                        d.insertText("\n" + reducedIndentation)
                    } else {
                        d.insertText("\n" + indentation)
                    }
                    event.accepted = true
                }
            }

            function loadNextQuestion() {
                questionLabel.text = (currentQuestionIndex + 1) + ". " + QuestionsHandler.getQuestion(questionsData, currentQuestionIndex)
                userAnswer = ""
                answerInput.text = ""
                timerValue = QuestionsHandler.getQuestionDifficulty(questionsData, currentQuestionIndex) === "Hard" ? 2*timeLimit : timeLimit
                countdownTimer.start()
                resultText.enabled = false
                answerInput.readOnly = false
                isCurrentAnswerCorrect = false
            }

            function resetTest() {
                resultText.enabled = false
                timerValue = QuestionsHandler.getQuestionDifficulty(questionsData, currentQuestionIndex) === "Hard" ? 2*timeLimit : timeLimit
                countdownTimer.start()
                quizComplete = false
                resultsModel.clear()
                sessionObject.visitedNumbers[sessionObject.topic] = []
                correctAnswers = 0
                currentQuestionIndex = 0
                questionLabel.text = (currentQuestionIndex + 1) + ". Implement a " + QuestionsHandler.getQuestion(questionsData, currentQuestionIndex)
                answerInput.text = ""
                answerInput.readOnly = false
                clock.enabled = true
                isCurrentAnswerCorrect = false
            }

            function insertText(textToInsert) {
                let cursorPos = answerInput.cursorPosition;
                let textBeforeCursor = answerInput.text.slice(0, cursorPos);
                let textAfterCursor = answerInput.text.slice(cursorPos);
                answerInput.text = textBeforeCursor + textToInsert + textAfterCursor;
                answerInput.cursorPosition = cursorPos + textToInsert.length;
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
                    id: emojis
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
                                radius: 10
                                color: "transparent"

                                Text {
                                    id: questionLabel
                                    font.family: "Noto Color Emoji"
                                    text: model.similarity === "Highly Similar" 
                                    ? "👏"
                                    : model.similarity === "Moderately Similar" 
                                    ? "👍"
                                    : "👎"
                                    font.pixelSize: 40
                                    color: themeObject.textColor
                                    font.bold: sessionObject.isFontBold
                                    anchors.centerIn: parent
                                }
                            }
                        }
                    }
                }

                Text {
                    id: questionLabel
                    text: (currentQuestionIndex + 1) +  ". Implement a " + QuestionsHandler.getQuestion(questionsData, currentQuestionIndex)
                    font.pixelSize: 24
                    font.bold: sessionObject.isFontBold
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
                    font.family: "Noto Color Emoji"
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
                    font.family: "Noto Color Emoji"
                    font.pixelSize: 100
                    Layout.alignment: Qt.AlignHCenter
                    visible: quizComplete
                }

                RowLayout {
                    spacing: 20

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
                        radius: 10
                        visible: !quizComplete

                        Text {
                            text: QuestionsHandler.getQuestionDifficulty(questionsData, currentQuestionIndex)
                            font.pixelSize: 14
                            font.bold: sessionObject.isFontBold
                            anchors.centerIn: parent
                            color: themeObject.textColor
                        }
                    }

                    Rectangle {
                        id: shareOnX
                        height: 25
                        width: 70
                        radius: 10
                        visible: isCurrentAnswerCorrect && !quizComplete

                        Image {
                            source: "x-twitter.svg"
                            fillMode: Image.PreserveAspectFit 
                            anchors.fill: parent

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    let question = QuestionsHandler.getQuestion(questionsData, currentQuestionIndex)
                                    Qt.openUrlExternally("https://x.com/intent/post?text=Just+solved+" + question + "+on+%40Hedgehog%21+🦔+%0A%0A+https://github.com/kounkou/Hedgehog")
                                }
                            }
                        }
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    Rectangle {
                        id: clock
                        height: 25
                        width: clockText.width + 20
                        visible: !quizComplete
                        opacity: countdownTimer.running ? 1 : 0.5
                        color: {
                            if (timerValue < 30) {
                                    return themeObject.buttonHardColor
                                } else if (timerValue < 60) {
                                    return themeObject.buttonMediumColor
                                } else {
                                    return themeObject.buttonColor
                                }
                            }
                        radius: 10

                        Text {
                            id: clockText
                            text: (
                                sessionObject.visitedNumbers[sessionObject.topic] && sessionObject.visitedNumbers[sessionObject.topic].length + 1 || 0) + "/" + QuestionsHandler.getTotalQuestions(questionsData) + " Time left: " + (
                                QuestionsHandler.getQuestionDifficulty(questionsData, currentQuestionIndex) === "Hard" ? timerValue : timerValue
                            ) + "s"
                            Layout.alignment: Qt.AlignRight
                            font.pixelSize: 14
                            anchors.centerIn: parent
                            font.bold: sessionObject.isFontBold
                            font.family: "Noto Color Emoji"
                            color: themeObject.textColor
                        }
                    }

                    ComboBox {
                        id: languageComboBox
                        model: [ "C++", "Go" ]
                        currentIndex: {
                            var value = 0;

                            if (sessionObject.language === "C++") {
                                value = 0;
                            } else if (sessionObject.language === "Go") {
                                value = 1;
                            }

                            currentLanguage = sessionObject.language

                            return value
                        }
                        enabled: !submitted
                        visible: !quizComplete && sessionObject.topic === "Programming"
                        Layout.alignment: Qt.AlignRight

                        MouseArea {
                            id: comboBoxMouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            acceptedButtons: Qt.NoButton
                        }

                        background: Rectangle {
                            radius: 10
                            color: comboBoxMouseArea.containsMouse ? themeObject.buttonHoveredColor : themeObject.buttonColor
                            border.color: themeObject.buttonBorderColor
                            border.width: 1
                        }

                        contentItem: Text {
                            text: languageComboBox.currentText
                            font.bold: sessionObject.isFontBold
                            elide: Text.ElideRight
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            anchors.fill: parent
                            anchors.margins: 10
                            color: themeObject.textColor
                        }

                        onActivated: {
                            currentLanguage = languageComboBox.currentText
                            sessionObject.language = currentLanguage
                            sessionObject.saveSession()
                            d.updateLanguage(currentLanguage)
                        }
                    }
                }

                Rectangle {
                    id: backgroundRect
                    width: parent.width
                    height: 450
                    color: themeObject.textAreaBackgroundColor
                    border.width: 1
                    border.color: themeObject.textAreaBorderColor
                    radius: 10
                    visible: !quizComplete && (answerInput.visible || aiOutput.visible)

                    ScrollView {
                        anchors.fill: parent
                        clip: true

                        TextArea {
                            id: answerInput
                            anchors.fill: backgroundRect
                            readOnly: submitted
                            placeholderText: QuestionsHandler.getQuestionPlaceHolder(questionsData, sessionObject.language, currentQuestionIndex, sessionObject.selectedCategories[sessionObject.topic])
                            font.family: "Courier New"
                            font.pixelSize: 16
                            font.bold: sessionObject.isFontBold
                            color: themeObject.textColor
                            padding: 10
                            antialiasing: true
                            wrapMode: Text.Wrap
                            visible: !quizComplete

                            onTextChanged: {
                                userAnswer = text
                                if (!countdownTimer.running && !submitted) {
                                    countdownTimer.start()
                                }
                            }

                            Component.onCompleted: {
                                documentHandler.setDocument(answerInput.textDocument, themeObject.theme)
                            }

                            palette {
                                highlight: "#B4D5FE"
                                highlightedText: "#202020"
                            }

                            property bool processing: false
                            selectByMouse: true

                            Keys.onPressed: {
                                d.handleIdentation(event)
                            }
                        }
                        TextArea {
                            id: aiOutput
                            anchors.fill: backgroundRect
                            readOnly: submitted
                            font.family: "Courier New"
                            font.pixelSize: 16
                            font.bold: sessionObject.isFontBold
                            color: themeObject.textColor
                            padding: 10
                            antialiasing: true
                            wrapMode: Text.Wrap
                            visible: !quizComplete && !answerInput.visible
                            textFormat: TextEdit.RichText

                            palette {
                                highlight: "#B4D5FE"
                                highlightedText: "#202020"
                            }

                            selectByMouse: true
                        }
                    }
                }

                RowLayout {
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

                    Item {
                        Layout.fillWidth: true
                    }

                    Button {
                        id: pause
                        text: countdownTimer.running ? qsTr("Pause timer") : qsTr("Resume timer")
                        onClicked: d.pauseStartTimer()
                        Layout.alignment: Qt.AlignHCenter
                        enabled: !submitted
                        visible: !quizComplete
                        width: 200 
                        height: 50
                        font.bold: sessionObject.isFontBold

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
                            radius: 10
                            border.width: 1
                            border.color: themeObject.buttonBorderColor
                            color: {
                                return pause.hovered ? themeObject.buttonHoveredColor : themeObject.buttonColor
                            }
                        }
                    }

                    Button {
                        id: redo
                        text: qsTr("Retry")
                        onClicked: d.goToQuestion(currentQuestionIndex)
                        Layout.alignment: Qt.AlignHCenter
                        visible: !quizComplete
                        width: 200
                        height: 50
                        font.bold: sessionObject.isFontBold

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
                            radius: 10
                            border.width: 1
                            border.color: themeObject.buttonBorderColor
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
                        font.bold: sessionObject.isFontBold
                        Layout.alignment: Qt.AlignHCenter

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
                            radius: 10
                            border.width: 1
                            border.color: themeObject.buttonBorderColor
                            color: {
                                return restartButton.hovered ? themeObject.buttonHoveredColor : themeObject.buttonColor
                            }
                        }
                    }

                    Button {
                        id: nextButton
                        text: "Next"
                        visible: !quizComplete
                        width: 200
                        height: 50
                        font.bold: sessionObject.isFontBold
                        Layout.alignment: Qt.AlignHCenter

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
                            radius: 10
                            border.width: 1
                            border.color: themeObject.buttonBorderColor
                            color: {
                                return nextButton.hovered ? themeObject.buttonHoveredColor : themeObject.buttonColor
                            }
                        }
                    }

                    Button {
                        id: homeButton
                        text: "Return"
                        width: 200
                        height: 50
                        font.bold: sessionObject.isFontBold
                        Layout.alignment: Qt.AlignHCenter

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
                            radius: 10
                            border.width: 1
                            border.color: themeObject.buttonBorderColor
                            color: {
                                return homeButton.hovered ? themeObject.buttonHoveredColor : themeObject.buttonColor
                            }
                        }
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    Rectangle {
                        id: viewAiAnswerRect
                        
                        height: 25
                        width: viewAiAnswerText.width + 20
                        color: answerInput.visible ? themeObject.buttonColor : themeObject.buttonMediumColor
                        opacity: submitted ? 1 : 0.5
                        enabled: submitted
                        radius: 10
                        visible: !quizComplete && aiComment.length > 0

                        Text {
                            id: viewAiAnswerText
                            text: "View AI Comments"
                            anchors.centerIn: parent
                            font.pixelSize: 14
                            font.bold: sessionObject.isFontBold
                            color: answerInput.visible ? themeObject.textColor : "#F7F7F7"
                        }

                        MouseArea {
                            anchors.fill: parent

                            onClicked: {
                                answerInput.visible = !answerInput.visible

                            }
                        }
                    }

                    Rectangle {
                        id: viewSubmission
                        
                        height: 25
                        width: viewSubmissionText.width + 20
                        color: root.showSolution ? themeObject.buttonColor : themeObject.buttonActionColor
                        opacity: submitted ? 1 : 0.5
                        enabled: submitted
                        radius: 10
                        visible: !quizComplete

                        Text {
                            id: viewSubmissionText
                            text: "View submission"
                            anchors.centerIn: parent
                            font.pixelSize: 14
                            font.bold: sessionObject.isFontBold
                            color: root.showSolution ? themeObject.textColor : "#F7F7F7"
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

                    Button {
                        id: validate
                        text: qsTr("Submit")
                        onClicked: d.validateAnswer(currentLanguage)
                        Layout.alignment: Qt.AlignRight
                        visible: !quizComplete
                        enabled: !submitted && answerInput.length > 0
                        opacity: enabled ? 1 : 0.5
                        width: 200
                        height: 50
                        font.bold: sessionObject.isFontBold

                        contentItem: Text {
                            text: validate.text
                            font: validate.font
                            opacity: enabled ? 1.0 : 0.5
                            color: "#F7F7F7"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            elide: Text.ElideRight
                        }

                        background: Rectangle {
                            radius: 10
                            border.width: 1
                            border.color: themeObject.buttonBorderColor
                            color: {
                                return themeObject.buttonSubmitColor
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
