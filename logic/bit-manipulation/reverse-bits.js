var question = [
    {
        id: "33",
        category: "Bit Manipulation",
        placeHolderCpp: `uint32_t reverseBits(uint32_t n) {\n    ...\n};\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func reverseBits(n uint32) uint32 {\n    ...\n};\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        difficulty: "Medium",
        question: "Write a function to reverse the bits of a 32-bit unsigned integer.",
        answerImage: "",
        answerCpp: `uint32_t reverseBits(uint32_t n) {
    uint32_t result = 0;
    for (int i = 0; i < 32; ++i) {
        result <<= 1;
        result |= (n & 1);
        n >>= 1;
    }
    return result;
}
`,
        answerGo: `func reverseBits(n uint32) uint32 {
    result := uint32(0)
    for i := 0; i < 32; i++ {
        result <<= 1
        result |= n & 1
        n >>= 1
    }
    return result
}
`
    }
]
