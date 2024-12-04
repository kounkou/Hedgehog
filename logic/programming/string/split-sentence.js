var question = [
    {
        id: "split",
        category: "String",
        placeHolderCpp: `vector<string> splitSentence(const string& sentence) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `{\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        difficulty: "Medium",
        question: "Split a sentence into words",
        answerImage: "",
        answerCpp: `vector<string> splitSentence(const string& sentence) {
    stringstream ss(sentence);
    return {
        istream_iterator<string>(ss), {}
    };
}`,
        answerGo: ``
    }
]
