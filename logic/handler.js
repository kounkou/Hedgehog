//     // { id: "8", difficulty: "Medium", question: "Coin change", answerImage: "../code-snipets/coin_change.png", answer: "int coinChange(vector<int>& coins, int x) {    if (x <= 0) return 0;    int best = INT_MAX;    for (auto& c : coins) {         if (x - c >= 0) {              int res = coinChange(coins, x - c);              if (res >= 0 && res < best) {                 best = res + 1;              }          }     }     return best == INT_MAX ? -1 : best;}" },

function getQuestionPlaceHolder(questionsData, currentLanguage, questionIndex, selectedCategories) {
    // If no category is selected, assume all categories are selected
    const categories = !selectedCategories || selectedCategories.length === 0
        ? questionsData.map(question => question.category) // Take all categories
        : selectedCategories;

    if (questionIndex < questionsData.length) {
        const question = questionsData[questionIndex];

        // Check if the current question's category is in the selected categories
        const isCategorySelected = categories.includes(question.category);

        if (isCategorySelected) {
            if (currentLanguage === "C++") {
                return question.placeHolderCpp;
            } else if (currentLanguage === "Go") {
                return question.placeHolderGo;
            }
        } else {
            return "No questions available for the selected categories";
        }
    } else {
        return "No more questions";
    }
}

function getCategory(questionsData, questionIndex) {
    if (questionIndex < questionsData.length) {
        return questionsData[questionIndex].category
    } else {
        return "No more questions"
    }
}

function getQuestion(questionsData, questionIndex) {
    if (questionIndex < questionsData.length) {
        return questionsData[questionIndex].question
    } else {
        return "No more questions"
    }
}

function getQuestionID(questionsData, questionIndex) {
    if (questionIndex < questionsData.length) {
        return questionsData[questionIndex].id
    } else {
        return "No more questions"
    }
}

function getQuestionDifficulty(questionsData, questionIndex) {
    if (questionIndex < questionsData.length) {
        return questionsData[questionIndex].difficulty
    } else {
        return "Unknown"
    }
}

function getAnswer(questionsData, currentLanguage, questionIndex) {
    if (questionIndex < questionsData.length) {
        if (currentLanguage === "C++") {
            return questionsData[questionIndex].answerCpp
        } else if (currentLanguage === "Go") {
            return questionsData[questionIndex].answerGo
        }
    } else {
        return ""
    }
}

function getAnswerDetails(questionsData, questionIndex) {
    if (questionIndex < questionsData.length) {
        return {
            title: questionsData[questionIndex].question,
            source: questionsData[questionIndex].answerImage,
        }
    } else {
        return ""
    }
}

function getTotalQuestions(questionsData) {
    return questionsData.length
}

function getTotalSections() {
    return 9
}

function getLevenshteinDistance(s, t) {
    const m = s.length;
    const n = t.length;
    const d = Array.from({ length: m + 1 }, () => Array(n + 1).fill(0));

    for (let i = 0; i <= m; i++) {
        for (let j = 0; j <= n; j++) {
            if (i === 0) {
                d[i][j] = j;  // Deletions
            } else if (j === 0) {
                d[i][j] = i;  // Insertions
            } else {
                const cost = s[i - 1] === t[j - 1] ? 0 : 1;
                d[i][j] = Math.min(
                    d[i - 1][j] + 1,        // Deletion
                    d[i][j - 1] + 1,        // Insertion
                    d[i - 1][j - 1] + cost  // Substitution
                );
            }
        }
    }

    const distance = d[m][n];
    const maxLength = Math.max(m, n);
    const smallChangeThreshold = maxLength * 0.05;     // 5% of the longer string
    const moderateChangeThreshold = maxLength * 0.10;  // 10% of the longer string

    let similarityStatus;

    if (distance <= smallChangeThreshold) {
        similarityStatus = "Highly Similar";
    } else if (distance <= moderateChangeThreshold) {
        similarityStatus = "Moderately Similar";
    } else {
        similarityStatus = "Not Similar";
    }

    return {
        distance: distance,
        similarityStatus: similarityStatus,
        smallChangeThreshold: smallChangeThreshold,
        moderateChangeThreshold: moderateChangeThreshold
    };
}
