var question = [
    {
        id: "Range queries",
        category: "Segment Tree",
        placeHolderCpp: `vector<int> tree;\n\nvoid build(int node, int start, int end, vector<int>& arr) {\n    //...\n}\n\nint query(int node, int start, int end, int L, int R) {\n    //...\n}\n\nvoid update(int node, int start, int end, int idx, int val) {\n    //...\n}`,
        placeHolderGo: `type SegmentTree struct {\n    tree []int\n}\n\nfunc (st *SegmentTree) Build(node, start, end int, arr []int) {\n    //...\n}\n\nfunc (st *SegmentTree) Query(node, start, end, L, R int) int {\n    //...\n}\n\nfunc (st *SegmentTree) Update(node, start, end, idx, val int) {\n    //...\n}`,
        difficulty: "Hard",
        question: "Range sum queries and point updates.",
        answerImage: "",
        answerCpp: `
vector<int> tree;
void build(int node, int start, int end, vector<int>& arr) {
    if (start == end) {
        tree[node] = arr[start];
    } else {
        int mid = (start + end) / 2;
        build(2 * node, start, mid, arr);
        build(2 * node + 1, mid + 1, end, arr);
        tree[node] = tree[2 * node] + tree[2 * node + 1];
    }
}

int query(int node, int start, int end, int L, int R) {
    if (R < start || end < L) return 0;
    if (L <= start && end <= R) return tree[node];
    int mid = (start + end) / 2;
    int left = query(2 * node, start, mid, L, R);
    int right = query(2 * node + 1, mid + 1, end, L, R);
    return left + right;
}

void update(int node, int start, int end, int idx, int val) {
    if (start == end) {
        tree[node] = val;
    } else {
        int mid = (start + end) / 2;
        if (start <= idx && idx <= mid)
            update(2 * node, start, mid, idx, val);
        else
            update(2 * node + 1, mid + 1, end, idx, val);
        tree[node] = tree[2 * node] + tree[2 * node + 1];
    }
}`,
        answerGo: `
type SegmentTree struct {
    tree []int
}

func (st *SegmentTree) Build(node, start, end int, arr []int) {
    if start == end {
        st.tree[node] = arr[start]
    } else {
        mid := (start + end) / 2
        st.Build(2 * node, start, mid, arr)
        st.Build(2 * node + 1, mid + 1, end, arr)
        st.tree[node] = st.tree[2 * node] + st.tree[2 * node + 1]
    }
}

func (st *SegmentTree) Query(node, start, end, L, R int) int {
    if R < start || end < L {
        return 0
    }
    if L <= start && end <= R {
        return st.tree[node]
    }
    mid := (start + end) / 2
    left := st.Query(2 * node, start, mid, L, R)
    right := st.Query(2 * node + 1, mid + 1, end, L, R)
    return left + right
}

func (st *SegmentTree) Update(node, start, end, idx, val int) {
    if start == end {
        st.tree[node] = val
    } else {
        mid := (start + end) / 2
        if start <= idx && idx <= mid {
            st.Update(2 * node, start, mid, idx, val)
        } else {
            st.Update(2 * node + 1, mid + 1, end, idx, val)
        }
        st.tree[node] = st.tree[2 * node] + st.tree[2 * node + 1]
    }
}`
    },
]
