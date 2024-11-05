var question = [
    {
        id: "Permutations",
        category: "Combinatorics",
        placeHolderCpp: `int countPermutations(int n, int k) {\n    int result = 1;\n    for (int i = 0; i < k; ++i) {\n        result *= (n - i);\n    }\n    ...\n}\n`,
        placeHolderGo: `func countPermutations(n int, k int) int {\n    result := 1\n    for i := 0; i < k; i++ {\n        result *= (n - i)\n    }\n    ...\n}\n`,
        difficulty: "Medium",
        question: "Ways to arrange k items from a set of n-length permutations.",
        answerImage: "",
        answerCpp: `int countPermutations(int n, int k) {
    int result = 1;\n    for (int i = 0; i < k; ++i) {
        result *= (n - i);
    }

    return result;
}`,
        answerGo: `func countPermutations(n int, k int) int {
    result := 1
    
    for i := 0; i < k; i++ {
        result *= (n - i)
    }
    
    return result\n}\n`
    }
]