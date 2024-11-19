import QtQuick 2.15

QtObject {
    id: sessionObject

    property var    selectedCategories: ({})
    property string theme: "white"
    property var    successfulImplementations: ({})
    property string performanceRating: "N/A"
    property string lastPerformanceUpdateDate: ""
    property int    attempted: 0
    property var    visitedNumbers: ({})
    property string language: "C++"
    property string topic: "Programming"
    property bool   automaticThemeSetting: false
    property bool   fontSetting: false
    property int    todayVisitedNumbers: 0
    property int    lastDayVisitedNumbers: 0
    property bool   isFontBold: false
    property string apiKey: ""

    function getTheme() {
        if (automaticThemeSetting) {
            var t = documentHandler.isDarkMode() ? "dark" : "light"
            themeObject.theme = t
            return t
        }
        return themeObject.theme;
    }

    function getThemeToLoad(data) {
        if (automaticThemeSetting) {
            var t = documentHandler.isDarkMode() ? "dark" : "light"
            themeObject.theme = t
            return t
        }

        themeObject.theme = data.theme
        return data.theme
    }

    function saveSession() {
        var sessionData = {
            selectedCategories: selectedCategories, 
            successfulImplementations: successfulImplementations,
            performanceRating: performanceRating,
            lastPerformanceUpdateDate: lastPerformanceUpdateDate,
            attempted: attempted,
            visitedNumbers: visitedNumbers,
            language: language,
            topic: topic,
            automaticThemeSetting: automaticThemeSetting,
            theme: getTheme(),
            fontSetting: fontSetting,
            isFontBold: isFontBold,
            lastDayVisitedNumbers: lastDayVisitedNumbers,
            todayVisitedNumbers: todayVisitedNumbers,
            apiKey: apiKey
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
                selectedCategories = data.selectedCategories || {};                
                successfulImplementations = data.successfulImplementations || {};
                performanceRating = data.performanceRating || "N/A";
                lastPerformanceUpdateDate = data.lastPerformanceUpdateDate || "";
                themeObject.theme = theme;
                attempted = data.attempted || 0;
                visitedNumbers = data.visitedNumbers || {};
                language = data.language || "";
                topic = data.topic || "";
                automaticThemeSetting = data.automaticThemeSetting || false;
                theme = getThemeToLoad(data) || theme;
                fontSetting = data.fontSetting || false;
                isFontBold = data.isFontBold || false;
                lastDayVisitedNumbers = data.lastDayVisitedNumbers || 0;
                todayVisitedNumbers = data.todayVisitedNumbers || 0;
                apiKey = data.apiKey || "";
            } catch (e) {
                console.error("Failed to parse session data: " + e);
            }
        }
    }

    function getCurrentDate() {
        var today = new Date();
        return today.getFullYear() + "-" + (today.getMonth() + 1) + "-" + today.getDate();
    }

    function getCurrentDay() {
        var today = new Date();
        var daysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
        var dayOfWeek = daysOfWeek[today.getDay()];

        return dayOfWeek
    }

    function getCurrentTime() {
        var today = new Date();
        var hours = today.getHours();
        var minutes = today.getMinutes();

        hours = hours < 10 ? "0" + hours : hours;
        minutes = minutes < 10 ? "0" + minutes : minutes;

        return hours + ":" + minutes;
    }

   function resetAgedQuestions(today, lastPerformanceUpdateDate) {
        if (today != lastPerformanceUpdateDate) {
            lastDayVisitedNumbers = todayVisitedNumbers
            todayVisitedNumbers = 0

            for (var questionId in successfulImplementations) {
                if (successfulImplementations.hasOwnProperty(questionId)) {
                    var questionData = successfulImplementations[questionId];

                    if (questionData.count >= 5) {
                        questionData.age += 1;

                        if (questionData.age >= 5) {
                            questionData.count = 0;
                            questionData.age = 0;

                            var index = visitedNumbers[sessionObject.topic].indexOf(questionId);
                            if (index > -1) {
                                visitedNumbers[sessionObject.topic].splice(index, 1);
                            }
                        }
                    }
                    successfulImplementations[questionId] = questionData;
                }
            }
        }
    }

    function updatePerformanceRatingForDay() {
        var today = getCurrentDate();

        var totalSuccessStreak = 0;
        var totalSuccessfulCount = 0;

        for (var questionId in successfulImplementations) {
            totalSuccessStreak += successfulImplementations[questionId].streak || 0;
            totalSuccessfulCount += successfulImplementations[questionId].count || 0;
        }

        var newPerformanceRating = ""

        if (totalSuccessfulCount < 5 || totalSuccessStreak < 0.5 * attempted) {
            newPerformanceRating = "Bad";
        } else if (totalSuccessfulCount >= 5 && totalSuccessfulCount <= 10 && totalSuccessStreak >= 0.5 * attempted && totalSuccessStreak < 7.5 * attempted) {
            newPerformanceRating = "Fair";
        } else if (totalSuccessfulCount > 10 && totalSuccessStreak >= 7.5 * attempted) {
            newPerformanceRating = "Excellent";
        }

        resetAgedQuestions(today, lastPerformanceUpdateDate);

        if (lastPerformanceUpdateDate === today && performanceRating === newPerformanceRating) {
            console.log("Performance rating already updated for today.");
            return;
        }

        performanceRating = newPerformanceRating

        lastPerformanceUpdateDate = today;

        saveSession();
    }

    function algorithmAttempt(questionId, successful, spentTime) {
        if (!successfulImplementations.hasOwnProperty(questionId)) {
            successfulImplementations[questionId] = {
                count: 0, 
                age: 0, 
                streak: 0,
                spentTime: {
                    average: 0,
                    spentTimes: []
                }
            };
        }

        if (successful) {
            successfulImplementations[questionId].streak += 1;
            successfulImplementations[questionId].count += 1;

            let currentAverage = successfulImplementations[questionId].spentTime.average;
            let count = successfulImplementations[questionId].count;
            successfulImplementations[questionId].spentTime.average = 
                Number((currentAverage + (spentTime - currentAverage) / count).toFixed(2));

            let day = getCurrentDay();
            var today = getCurrentDate();
            let currentTime = getCurrentTime();

            let dayEntry = successfulImplementations[questionId].spentTime.spentTimes.find(entry => entry.day === day && entry.today === today);

            if (dayEntry) {
                dayEntry.times.push({ time: currentTime, spentTime: spentTime });
            } else {
                successfulImplementations[questionId].spentTime.spentTimes.push({
                    day: day,
                    today: today,
                    times: [{ time: currentTime, spentTime: spentTime }]
                });
            }
        } else {
            successfulImplementations[questionId].streak = 0;
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
