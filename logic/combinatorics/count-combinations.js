var question = [
    {
        id: "count combis",
        category: "Combinatorics",
        placeHolderCpp: `int countCombinations(int n, int k) {\n    // Base cases\n    if (k == 0 || k == n) return 1;\n    ...\n}\n`,
        placeHolderGo: `func countCombinations(n int, k int) int {\n    // Base cases\n    if k == 0 || k == n {\n        return 1\n    }\n    ...\n}\n`,
        difficulty: "Easy",
        question: "Ways to choose k items from n items (no order)",
        answerImage: "",
        answerCpp: `int countCombinations(int n, int k) {
    if (k == 0 || k == n) return 1;
    
    return countCombinations(n - 1, k - 1) + countCombinations(n - 1, k);
}
`,
        answerGo: `func countCombinations(n int, k int) int {
    if k == 0 || k == n {
        return 1
    }
    return countCombinations(n-1, k-1) + countCombinations(n-1, k)
}`
    },
]