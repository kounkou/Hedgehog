var question = [
    {
        id: "GCD",
        category: "Mathematics",
        placeHolderCpp: `int gcd(int a, int b) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func gcd(a int, b int) int {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        difficulty: "Easy",
        question: "Greatest Common Divisor (GCD)",
        answerImage: "",
        answerCpp: `int gcd(int a, int b) {
    if (b == 0)
        return a;
    return gcd(b, a % b);
}`,
        answerGo: `func gcd(a int, b int) int {
    if b == 0 {
        return a
    }
    return gcd(b, a % b)
}`
    }
]
