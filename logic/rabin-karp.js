var linearSearchQuestions = [
    {
        id: "19",
        category: "String",
        placeHolderCpp: `{\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `{\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        spaceComplexity: "O()",
        timeComplexity: "O()",
        difficulty: "Hard",
        question: "Rabin-Karp",
        answerImage: "",
        answerCpp: `void rabinKarp(string text, string pattern) {
    int n = text.size(), m = pattern.size();
    int p = 0, t = 0, h = 1;
    
    for (int i = 0; i < m - 1; i++)
        h = (h * d) % q;
    
    for (int i = 0; i < m; i++) {
        p = (d * p + pattern[i]) % q;
        t = (d * t + text[i]) % q;
    }
    
    for (int i = 0; i <= n - m; i++) {
        if (p == t) {
            bool match = true;
            for (int j = 0; j < m; j++) {
                if (text[i + j] != pattern[j]) {
                    match = false;
                    break;
                }
            }
            if (match)
                cout << "Pattern found at index " << i << endl;
        }
        
        if (i < n - m) {
            t = (d * (t - text[i] * h) + text[i + m]) % q;
            if (t < 0)
                t = (t + q);
        }
    }
}`,
        answerGo: ``
    }
]
