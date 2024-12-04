var question = [
    {
        id: "Lazy propag.",
        category: "Segment Tree",
        placeHolderCpp: `vector<int> tree;\n\nvoid build(int node, int start, int end, vector<int>& arr) {\n    //...\n}\n\nint query(int node, int start, int end, int L, int R) {\n    //...\n}\n\nvoid updateRange(int node, int start, int end, int L, int R, int val) {\n    //...\n}`,
        placeHolderGo: `type SegmentTree struct {\n    tree []int\n    lazy []int\n}\n\nfunc (st *SegmentTree) Build(node, start, end int, arr []int) {\n    //...\n}\n\nfunc (st *SegmentTree) Query(node, start, end, L, R int) int {\n    //...\n}\n\nfunc (st *SegmentTree) UpdateRange(node, start, end, L, R, val int) {\n    //...\n}`,
        difficulty: "Hard",
        question: "Lazy propagation for range updates and range queries.",
        answerImage: "",
        answerCpp: `
vector<int> tree, lazy;

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

void updateRange(int node, int start, int end, int L, int R, int val) {
if (lazy[node] != 0) {
    tree[node] += (end - start + 1) * lazy[node];
    if (start != end) {
        lazy[2 * node] += lazy[node];
        lazy[2 * node + 1] += lazy[node];
    }
    lazy[node] = 0;
}
if (start > end || start > R || end < L) return;
if (start >= L && end <= R) {
    tree[node] += (end - start + 1) * val;
    if (start != end) {
        lazy[2 * node] += val;
        lazy[2 * node + 1] += val;
    }
    return;
}
int mid = (start + end) / 2;
updateRange(2 * node, start, mid, L, R, val);
updateRange(2 * node + 1, mid + 1, end, L, R, val);
tree[node] = tree[2 * node] + tree[2 * node + 1];
}

int query(int node, int start, int end, int L, int R) {
if (lazy[node] != 0) {
    tree[node] += (end - start + 1) * lazy[node];
    if (start != end) {
        lazy[2 * node] += lazy[node];
        lazy[2 * node + 1] += lazy[node];
    }
    lazy[node] = 0;
}
if (start > end || start > R || end < L) return 0;
if (start >= L && end <= R) return tree[node];
int mid = (start + end) / 2;
int left = query(2 * node, start, mid, L, R);
int right = query(2 * node + 1, mid + 1, end, L, R);
return left + right;
}`,
        answerGo: `
type SegmentTree struct {
tree []int
lazy []int
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

func (st *SegmentTree) UpdateRange(node, start, end, L, R, val int) {
if st.lazy[node] != 0 {
    st.tree[node] += (end - start + 1) * st.lazy[node]
    if start != end {
        st.lazy[2 * node] += st.lazy[node]
        st.lazy[2 * node + 1] += st.lazy[node]
    }
    st.lazy[node] = 0
}
if start > end || start > R || end < L {
    return
}
if start >= L && end <= R {
    st.tree[node] += (end - start + 1) * val
    if start != end {
        st.lazy[2 * node] += val
        st.lazy[2 * node + 1] += val
    }
    return
}
mid := (start + end) / 2
st.UpdateRange(2 * node, start, mid, L, R, val)
st.UpdateRange(2 * node + 1, mid + 1, end, L, R, val)
st.tree[node] = st.tree[2 * node] + st.tree[2 * node + 1]
}

func (st *SegmentTree) Query(node, start, end, L, R int) int {
if st.lazy[node] != 0 {
    st.tree[node] += (end - start + 1) * st.lazy[node]
    if start != end {
        st.lazy[2 * node] += st.lazy[node]
        st.lazy[2 * node + 1] += st.lazy[node]
    }
    st.lazy[node] = 0
}
if start > end || start > R || end < L {
    return 0
}
if start >= L && end <= R {
    return st.tree[node]
}
mid := (start + end) / 2
left := st.Query(2 * node, start, mid, L, R)
right := st.Query(2 * node + 1, mid + 1, end, L, R)
return left + right
}`
    }
]