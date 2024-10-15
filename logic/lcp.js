var linearSearchQuestions = [
    {
        id: "20",
        category: "String",
        placeHolderCpp: `{\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `{\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        spaceComplexity: "O()",
        timeComplexity: "O()",
        difficulty: "",
        question: "",
        answerImage: "",
        answerCpp: `void insert(string word) {
    TrieNode* node = root;

    for (char c : word) {
        if (!node->children.count(c)) {
            node->children[c] = new TrieNode();
        }
        node = node->children[c];
    }
    node->isEnd = true;
}

string findLCP(vector<string>& strs) {
    root = new TrieNode();

    for (string word : strs) {
        insert(word);
    }

    TrieNode* node = root;
    string prefix = "";

    while (node && node->children.size() == 1) {
        for (auto it : node->children) {
            node = it.second;
            prefix += it.first;
            break;
        }
    }

    return prefix;
}`,
        answerGo: ``
    }
]
