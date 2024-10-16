var question = [
    {
        id: "20",
        category: "Trie",
        placeHolderCpp: `class Trie {\n    ...\n};\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `{\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        difficulty: "Medium",
        question: "Trie",
        answerImage: "",
        answerCpp: `struct TrieNode {
    bool end;
    unordered_map<char, shared_ptr<TrieNode>> children;
};

class Trie {
public:
    Trie() {
        root = make_unique<TrieNode>();
    }

    void insert(const string& word) {
        TrieNode* temp = root.get();

        for (char c : word) {
            if (temp->children.find(c) == temp->children.end()) {
                temp->children[c] = make_unique<TrieNode>();
            }
            temp = temp->children[c].get();
        }
        temp->end = true;
    }

    void insert(const string& word) {

    }

    bool search(const string& word) {
        const TrieNode* temp = root.get();

        for (char c : word) {
            if (temp->children.find(c) != temp->children.end()) {
                temp = temp->children[c].get();
            } else {
                return false;
            }
        }
        return temp->end;
    }

private:
    unique_ptr<TrieNode> root;
};
`,
        answerGo: ``
    }
]