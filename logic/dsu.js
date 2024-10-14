var DsuQuestions = [
    {
        id: "9",
        category: "Disjoint Set",
        placeHolderCpp: `class DSU {\n    ...\n};\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: "undefined",
        spaceComplexity: "O(N)",
        timeComplexity: "O(M x α(N))", // α() is the inverse Ackerman function
        difficulty: "Medium",
        question: "Disjoint Set Union",
        answerImage: "../code-snipets/dsu.png",
        answerCpp: `class DSU {
public:
    DSU(int n) : _p(n), _r(n, 0) {
        for (int i = 0; i < n; ++i) _p[i] = i;
    }

    int find(int v) {
        return v == _p[v] ? v : _p[v] = find(_p[v]);
    }

    void merge(int a, int b) {
        a = find(a);
        b = find(b);

        if (a != b) {
            if (_r[a] < _r[b]) swap(a, b);
            _p[b] = a;
            if (_r[a] == _r[b]) _r[a]++;
        }
    }

private:
    vector<int> _p, _r;
};`, answerGo: `
            undefined
            `,
    }
]