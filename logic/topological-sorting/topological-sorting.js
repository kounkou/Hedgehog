var question = [
    {
        id: "34",
        category: "Topological Sorting",
        placeHolderCpp: `void topologicalSort(int v, vector<bool>& visited, stack<int>& Stack) {\n    ...\n}\n\nvoid topoSortGraph(int V, vector<int> adj[]) {\n    ...\n}\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func topologicalSort(v int, visited []bool, stack *[]int) {\n    ...\n}\n\nfunc topoSortGraph(V int, adj [][]int) {\n    ...\n}\n\n\n\n\n\n\n`,
        difficulty: "Hard",
        question: "Topological Sort.",
        answerImage: "",
        answerCpp: `void topologicalSort(int v, vector<bool>& visited, stack<int>& stk, vector<int> graph[]) {
    visited[v] = true;
    
    for (int i : graph[v]) {
        if (!visited[i])
            topologicalSort(i, visited, stk, graph);
    }
    
    stk.push(v);
}

void topoSortGraph(int V, vector<int> graph[]) {
    stack<int> stk;
    vector<bool> visited(V, false);
    
    for (int i = 0; i < V; i++) {
        if (!visited[i])
            topologicalSort(i, visited, stk, graph);
    }
    
    while (!stk.empty()) {
        cout << stk.top() << " ";
        stk.pop();
    }
}`,
        answerGo: `func topologicalSort(v int, visited []bool, stk *[]int, graph [][]int) {
    visited[v] = true
    
    for _, i := range graph[v] {
        if !visited[i] {
            topologicalSort(i, visited, stk, graph)
        }
    }
    
    *stk = append(*stk, v)
}

func topoSortGraph(V int, graph [][]int) {
    stk := []int{}
    visited := make([]bool, V)
    
    for i := 0; i < V; i++ {
        if !visited[i] {
            topologicalSort(i, visited, &stk, graph)
        }
    }
    
    for i := len(stk) - 1; i >= 0; i-- {
        fmt.Print(stk[i], " ")
    }
}`
    }
]
