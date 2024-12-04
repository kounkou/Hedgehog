var question = [
    {
        id: "dfs rec.",
        category: "Graph",
        placeHolderCpp: `void dfs(int node) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func dfs(node int) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        spaceComplexity: "O(E + V)",
        timeComplexity: "O(E + V)",
        difficulty: "Easy",
        question: "DFS (Depth first search) recursive",
        answerImage: "../code-snipe ts/dfs_recursive.png",
        answerCpp: `void dfs(int node) {
    visited[node] = true;
    cout << node;

    for (int nei : graph[node]) {
        if (visited[nei]) continue;
        dfs(nei);
    }
}`,
        answerGo: `func dfs(node int) {
    visited[node] = true
    fmt.Println(node)

    for _, nei := range graph[node] {
        if visited[nei] {
	    continue
	}

        dfs(nei)
    }
}
`},
]
