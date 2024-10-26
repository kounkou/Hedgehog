var question = [
    {
        id: "Trie",
        category: "Trie",
        placeHolderCpp: `class Trie {\n    ...\n};\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `type TrieNode struct {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        difficulty: "Hard",
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

    bool search(const string& word) {
        TrieNode* temp = root.get();

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
        answerGo: `type TrieNode struct {
    End     bool
    Children map[rune]*TrieNode
}

type Trie struct {
    Root *TrieNode
}

func NewTrie() *Trie {
    return &Trie{Root: &TrieNode{Children: make(map[rune]*TrieNode)}}
}

func (t *Trie) Insert(word string) {
    temp := t.Root

    for _, c := range word {
        if _, exists := temp.Children[c]; !exists {
            temp.Children[c] = &TrieNode{Children: make(map[rune]*TrieNode)}
        }
        temp = temp.Children[c]
    }
    temp.End = true
}

func (t *Trie) Search(word string) bool {
    temp := t.Root

    for _, c := range word {
        if next, exists := temp.Children[c]; exists {
            temp = next
        } else {
            return false
        }
    }
    return temp.End
}`
    }
]