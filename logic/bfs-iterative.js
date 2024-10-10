var bfsQuestions = [
    {
        id: "2",
        placeHolderCpp: `void bfs(int start) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func bfs(start int) {{\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,

        difficulty: "Medium",
        question: "BFS (Bread first search) iterative",
        answerImage: "../code-snipets/bfs_iterative.png",
        answerCpp: `
void bfs(int start) {
    map<int, bool> visited;
    queue<int> q;
    q.push(start);
    visited[start] = true;

    while (!q.empty()) {
        int node = q.front();
        q.pop();
        cout << node;

        for (int nei : graph[node]) {
            if (visited[nei]) continue;
            visited[nei] = true;
            q.push(nei);
        }
    }
}`,
        answerGo: `
func bfs(start int) {
	visited := make(map[int]bool)
	q := []int{start}
	visited[start] = true

	for len(q) > 0 {
		node := q[0]
		q = q[1:]

		fmt.Println(node)

		for _, nei := range graph[node] {
			if visited[nei] {
				continue
			}
			visited[nei] = true
			q = append(q, nei)
		}
	}
}`}
]