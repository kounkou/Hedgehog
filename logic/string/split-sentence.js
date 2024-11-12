var question = [
    {
        id: "split",
        category: "String",
        placeHolderCpp: `vector<string> split_sentence(const string& sentence) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `{\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        difficulty: "Medium",
        question: "Split a sentence into words",
        answerImage: "",
        answerCpp: `vector<string> split_sentence(const string& sentence) {
    stringstream ss(sentence);
    string word;
    vector<string> words;
    
    while (ss >> word) {
        words.push_back(word);
    }
    
    return words;
}`,
        answerGo: ``
    }
]
