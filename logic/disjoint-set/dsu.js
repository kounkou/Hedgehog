var question = [
    {
        id: "dsu",
        category: "Disjoint Set",
        placeHolderCpp: `class DSU {\n    ...\n};\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `type DSU struct {\n    ...\n};\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
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
};`, answerGo: `type DSU struct {
    parent []int
    rank   []int
}

func NewDSU(n int) *DSU {
    dsu := &DSU{
        parent: make([]int, n),
        rank:   make([]int, n),
    }
    for i := 0; i < n; i++ {
        dsu.parent[i] = i
    }
    return dsu
}

func (dsu *DSU) Find(v int) int {
    if dsu.parent[v] != v {
        dsu.parent[v] = dsu.Find(dsu.parent[v])
    }
    return dsu.parent[v]
}

func (dsu *DSU) Merge(a, b int) {
    rootA := dsu.Find(a)
    rootB := dsu.Find(b)

    if rootA != rootB {
        if dsu.rank[rootA] < dsu.rank[rootB] {
            dsu.parent[rootA] = rootB
        } else if dsu.rank[rootA] > dsu.rank[rootB] {
            dsu.parent[rootB] = rootA
        } else {
            dsu.parent[rootB] = rootA
            dsu.rank[rootA]++
        }
    }
}`,
    }
]