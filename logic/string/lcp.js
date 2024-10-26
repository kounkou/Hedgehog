var question = [
    {
        id: "LCP",
        category: "String",
        placeHolderCpp: `string findLCP(vector<string>& strs) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func (t *Trie) Insert(word string) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        spaceComplexity: "O()",
        timeComplexity: "O()",
        difficulty: "Hard",
        question: "Longest Common Prefix (LCP)",
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
        answerGo: `type TrieNode struct {
    Children map[rune]*TrieNode
    IsEnd    bool
}

type Trie struct {
    Root *TrieNode
}

func NewTrie() *Trie {
    return &Trie{Root: &TrieNode{Children: make(map[rune]*TrieNode)}}
}

func (t *Trie) Insert(word string) {
    node := t.Root
    for _, c := range word {
        if _, exists := node.Children[c]; !exists {
            node.Children[c] = &TrieNode{Children: make(map[rune]*TrieNode)}
        }
        node = node.Children[c]
    }
    node.IsEnd = true
}

func FindLCP(strs []string) string {
    trie := NewTrie()
    for _, word := range strs {
        trie.Insert(word)
    }

    node := trie.Root
    prefix := ""

    for node != nil && len(node.Children) == 1 {
        for c, child := range node.Children {
            node = child
            prefix += string(c)
            break
        }
    }

    return prefix
}`
    }
]
