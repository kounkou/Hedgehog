var question = [
    {
        id: "count set bits",
        category: "Bit Manipulation",
        placeHolderCpp: `int countSetBits(int n) {\n    ...\n};\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func countSetBits(n int) int {\n    ...\n};\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        difficulty: "Easy",
        question: "count 1s in the binary representation of an integer.",
        answerImage: "",
        answerCpp: `int countSetBits(int n) {
    int count = 0;
    while (n) {
        count += n & 1;
        n >>= 1;
    }
    return count;
}
`,
        answerGo: `func countSetBits(n int) int {
    count := 0
    for n > 0 {
        count += n & 1
        n >>= 1
    }
    return count
}
`
    }
]
