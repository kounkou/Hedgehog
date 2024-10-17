var question = [
    {
        id: "28",
        category: "Recursion",
        placeHolderCpp: `int factorial(int n) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func factorial(n int) int {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        difficulty: "Easy",
        question: "Write a recursive algorithm to calculate the factorial of a number.",
        answerImage: "",
        answerCpp: `int factorial(int n) {
    if (n <= 1) {
        return 1;
    }

    return n * factorial(n - 1);
}`,
        answerGo: `func factorial(n int) int {
    if n <= 1 {
        return 1
    }
        
    return n * factorial(n-1)
}`
    }
]
