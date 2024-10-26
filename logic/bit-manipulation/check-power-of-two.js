var question = [
    {
        id: "power of 2",
        category: "Bit Manipulation",
        placeHolderCpp: `bool isPowerOfTwo(int n) {\n    ...\n};\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func isPowerOfTwo(n int) {\n    ...\n};\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        difficulty: "Easy",
        question: "Write a function to check if a given number is a power of two.",
        answerImage: "",
        answerCpp: `bool isPowerOfTwo(int n) {
    return n > 0 && (n & (n - 1)) == 0;
}
`,
        answerGo: `func isPowerOfTwo(n int) bool {
    return n > 0 && (n & (n - 1)) == 0
}
`
    }
]
