var question = [
    {
        id: "Topological sort",
        category: "Topo. Sort",
        placeHolderCpp: `void dfs(int node, map<int, bool>& visited, stack<int>& stk, vector<int> graph[]) {\n    ...\n}\n\nvoid topoSortGraph(vector<int> nodes, vector<int> graph[], int V) {\n    ...\n}\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func dfs(node int, visited []bool, stack *[]int, graph [][]int) {\n    ...\n}\n\nvoid topoSortGraph(vector<int> nodes, vector<int> graph[]) {\n    ...\n}\n\n\n\n\n\n\n`,
        difficulty: "Hard",
        question: "Topological Sort.",
        answerImage: "",
        answerCpp: `void dfs(int node, map<int, bool>& visited, stack<int>& stk, vector<int> graph[]) {
    visited[node] = true;
    
    for (int nei : graph[node]) {
        if (visited[nei]) continue;
        dfs(nei, visited, stk, graph);
    }
    
    stk.push(node);
}

void topoSortGraph(vector<int> nodes, vector<int> graph[], int V) {
    map<int, bool> visited(V, false);
    stack<int> stk;
    
    for (int node : nodes) {
        if (visited[node]) continue;
        dfs(node, visited, stk, graph);
    }
    
    while (!stk.empty()) {
        int node = stk.top();
        stk.pop();
        cout << node;
    }
}`,
        answerGo: `func dfs(v int, visited []bool, stk *[]int, graph [][]int) {
    visited[v] = true
    
    for _, nei := range graph[v] {
        if !visited[nei] {
            dfs(nei, visited, stk, graph)
        }
    }
    
    *stk = append(*stk, v)
}

func topoSortGraph(V int, graph [][]int) {
    visited := make([]bool, V)
    stk := []int{}
    
    for i := 0; i < V; i++ {
        if !visited[i] {
            dfs(i, visited, &stk, graph)
        }
    }
    
    for i := len(stk) - 1; i >= 0; i-- {
        fmt.Print(stk[i], " ")
    }
}`
    }
]
