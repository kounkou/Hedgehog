var question = [
    {
        id: "Fast exp.",
        category: "Mathematics",
        placeHolderCpp: `long long power(long long base, long long exp, long long mod) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func power(base, exp, mod int64) int64 {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        difficulty: "Medium",
        question: "Fast exponentiation",
        answerImage: "",
        answerCpp: `long long power(long long base, long long exp, long long mod) {
    long long result = 1;
    while (exp > 0) {
        if (exp % 2 == 1) {
            result = (result * base) % mod;
        }

        base = (base * base) % mod;
        exp /= 2;
    }
    return result;
}`,
        answerGo: `func power(base, exp, mod int64) int64 {
    result := int64(1)
    for exp > 0 {
        if exp%2 == 1 {
            result = (result * base) % mod
        }
        base = (base * base) % mod
        exp /= 2
    }
    return result
}`
    }
]
