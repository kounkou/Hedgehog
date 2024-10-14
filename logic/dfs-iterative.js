var dfsQuestions = [
    {
        id: "4",
        category: "DFS",
        placeHolderCpp: `void dfs(int start) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func dfs(start int) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        spaceComplexity: "O(E + V)",
        timeComplexity: "O(E + V)",
        difficulty: "Medium", question: "DFS (Depth first search) iterative",
        answerImage: "../code-snipets/dfs_iterative.png",
        answerCpp: `
void dfs(int start) {
    map<int, bool> visited;
    stack<int> stk;
    stk.push(start);

    while (!stk.empty()) {
        int node = stk.top();
        stk.pop();
        if (visited[node]) continue;
        cout << node;
        visited[node] = true;

        for (int x = graph[node].size() - 1; x >= 0; --x) {
            int nextNode = graph[node][x];
            if (visited[nextNode]) continue;
            stk.push(nextNode);
        }
    }
}`,
        answerGo: `
func dfs(start int) {
    visited:= make(map[int]bool)
    stk:= []int{ start }

    for len(stk) > 0 {
        node:= stk[len(stk) - 1]
		stk = stk[: len(stk)- 1]

    if visited[node] {
        continue
    }

    fmt.Println(node)
    visited[node] = true

    for x := len(graph[node]) - 1; x >= 0; x-- {
        nextNode:= graph[node][x]
        
        if !visited[nextNode] {
            stk = append(stk, nextNode)
        }
    }
}
}
`}
]