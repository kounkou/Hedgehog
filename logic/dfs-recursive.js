var dfsQuestions = [
    {
        id: "3",
        placeHolderCpp: `void dfs(int node) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func dfs(node int) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
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
        answerGo: `func dfs(start int) {
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
`},
]