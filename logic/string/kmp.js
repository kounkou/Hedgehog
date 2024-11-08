var question = [
    {
        id: "KMP",
        category: "String",
        placeHolderCpp: "vector<int> getLps(const string& p) {\n    ...\n}\n\nvoid kmp(const string& t, const string& p) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n",
        placeHolderGo: "func getLps(p string) []int {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
        spaceComplexity: "O()",
        timeComplexity: "O()",
        difficulty: "Hard",
        question: "KMP (Knuth-Morris-Pratt) algorithm",
        answerImage: "../code-snipets/kmp.png",
        answerCpp: `
vector<int> getLps(const string& p) {
    int sp = p.length();
    vector<int> lps(sp, 0);
    int i = 1, j = 0;
    
    while (i < sp) {
        if (p[i] == p[j]) lps[i++] = ++j;        
        else if (j>0)     j = lps[j-1];        
        else              lps[i++] = 0;
    }    
    return lps;
}

void kmp(const string& t, const string& p) {
    int st = t.length();    
    int sp = p.length();    
    int i = 0, j = 0;    
    vector<int> lps = getLps(p);

    while (i < st) {
        if (t[i] == p[j]) i++, j++;        
        if (j == m) cout << \"found at \" << i - j, j = lps[j - 1];        
        else if (i < n && t[i] != p[j]) j ? j = lps[j - 1] : i++;    
    }
}`, answerGo: `func getLps(p string) []int {
    sp := len(p)
    lps := make([]int, sp)
    j := 0

    for i := 1; i < sp; {
        if p[i] == p[j] {
            j++
            lps[i] = j
            i++
        } else {
            if j != 0 {
                j = lps[j-1]
            } else {
                lps[i] = 0
                i++
            }
        }
    }
    return lps
}

func kmp(t, p string) {
    st := len(t)
    sp := len(p)
    lps := getLps(p)
    j := 0

    for i := 0; i < st; {
        if p[j] == t[i] {
            i++
            j++
        }
        if j == sp {
            fmt.Printf("found at %d\n", i-j)
            j = lps[j-1]
        } else if i < st && p[j] != t[i] {
            if j != 0 {
                j = lps[j-1]
            } else {
                i++
            }
        }
    }
}`,
    },
]