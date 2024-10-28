import QtQuick 2.15

QtObject {
    id: sessionObject

    property var    selectedCategories: []
    property string theme: "white"
    property var    successStreaksPerQuestion: ({})
    property var    successfulImplementationsThisMonth: ({})
    property string performanceRating: "N/A"
    property string lastPerformanceUpdateDate: ""
    property int    attempted: 0
    property var    visitedNumbers: []
    property string language: ""

    function saveSession() {
        var sessionData = {
            selectedCategories: selectedCategories,
            theme: themeObject.theme,
            successStreaksPerQuestion: successStreaksPerQuestion,
            successfulImplementationsThisMonth: successfulImplementationsThisMonth,
            performanceRating: performanceRating,
            lastPerformanceUpdateDate: lastPerformanceUpdateDate,
            attempted: attempted,
            visitedNumbers: visitedNumbers,
            language: language
        };
        var content = JSON.stringify(sessionData, null, 4);
        var filePath = "sessionData.json";
        documentHandler.saveToFile(filePath, content);
    }

    function loadSession() {
        var filePath = "sessionData.json";
        var content = documentHandler.loadFromFile(filePath);
        if (content) {
            try {
                var data = JSON.parse(content);
                selectedCategories = data.selectedCategories || [];
                theme = data.theme || theme;
                successStreaksPerQuestion = data.successStreaksPerQuestion || {};
                successfulImplementationsThisMonth = data.successfulImplementationsThisMonth || {};
                performanceRating = data.performanceRating || "N/A";
                lastPerformanceUpdateDate = data.lastPerformanceUpdateDate || "";
                themeObject.theme = theme;
                attempted = data.attempted || 0;
                visitedNumbers = data.visitedNumbers || [];
                language = data.language || "";
            } catch (e) {
                console.error("Failed to parse session data: " + e);
            }
        }
    }

    function getCurrentDate() {
        var today = new Date();
        return today.getFullYear() + "-" + (today.getMonth() + 1) + "-" + today.getDate();
    }

   function resetAgedQuestions() {
        for (var questionId in successfulImplementationsThisMonth) {
            if (successfulImplementationsThisMonth.hasOwnProperty(questionId)) {
                var questionData = successfulImplementationsThisMonth[questionId];

                if (questionData.age >= 5) {
                    questionData.count = 0;
                    questionData.age = 0;

                    var index = visitedNumbers.indexOf(questionId);
                    if (index > -1) {
                        visitedNumbers.splice(index, 1);
                    }
                }
            }
        }
    }

    function updatePerformanceRatingForDay() {
        var today = getCurrentDate();

        var totalSuccessStreak = 0;
        var totalSuccessfulCount = 0;

        for (var questionId in successStreaksPerQuestion) {
            totalSuccessStreak += successStreaksPerQuestion[questionId] || 0;
            totalSuccessfulCount += successfulImplementationsThisMonth[questionId].count || 0;
        }

        var newPerformanceRating = ""

        if (totalSuccessfulCount < 5 || totalSuccessStreak < 0.5 * attempted) {
            newPerformanceRating = "Bad";
        } else if (totalSuccessfulCount >= 5 && totalSuccessfulCount <= 10 && totalSuccessStreak >= 0.5 * attempted && totalSuccessStreak < 7.5 * attempted) {
            newPerformanceRating = "Fair";
        } else if (totalSuccessfulCount > 10 && totalSuccessStreak >= 7.5 * attempted) {
            newPerformanceRating = "Excellent";
        }

        resetAgedQuestions();

        if (lastPerformanceUpdateDate === today && performanceRating === newPerformanceRating) {
            console.log("Performance rating already updated for today.");
            return;
        }

        performanceRating = newPerformanceRating

        lastPerformanceUpdateDate = today;

        if (successfulImplementationsThisMonth[questionId].count >= 5) {
            successfulImplementationsThisMonth[questionId].age += 1;
        }

        saveSession();
    }

    function algorithmAttempt(questionId, successful) {
        if (!successStreaksPerQuestion.hasOwnProperty(questionId)) {
            successStreaksPerQuestion[questionId] = 0;
        }
        if (!successfulImplementationsThisMonth.hasOwnProperty(questionId)) {
            successfulImplementationsThisMonth[questionId] = { count: 0, age: 0 };
        }

        if (successful) {
            successStreaksPerQuestion[questionId] += 1;
            successfulImplementationsThisMonth[questionId].count += 1;
        } else {
            successStreaksPerQuestion[questionId] = 0;
        }

        updatePerformanceRatingForDay();
        saveSession();
    }

    Component.onCompleted: {
        loadSession();
        saveSession();
        updatePerformanceRatingForDay();
    }
}
