var bfsQuestions = [
    {
        id: "1",
        placeHolderCpp: `void bfs(vector<int>& level, map<int, bool>& visited) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func bfs(level []int, visited map[int]bool) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        difficulty: "Medium",
        question: "BFS (Bread first search) recursive",
        answerImage: "../code-snipets/bfs_recursive.png",
        answerCpp: `void bfs(vector<int>& level, map<int, bool>& visited) {
    if (level.empty()) return;
    
    vector<int> nlevel;

    for (int node : level) {
        cout << node;
        
        for (int nei : graph[node]) {
            if (visited[nei]) continue;
            visited[nei] = true;
            nlevel.push_back(nei);
        }
    }

    bfs(nlevel, visited);
}`,
        answerGo: `func bfs(level []int, visited map[int]bool) {
    if len(level) == 0 {
		return
    }

	var nlevel []int

	for _, node := range level {
		fmt.Println(node)

		for _, nei := range graph[node] {
			if visited[nei] {
				continue
            }
			visited[nei] = true
			nlevel = append(nlevel, nei)
        }
    }

	bfs(nlevel, visited)
}`}
]