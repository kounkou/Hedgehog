var question = [
    {
        id: "Dijkstra",
        category: "Graph",
        placeHolderCpp: "vector<int> dijkstra(vector<PairType> graph[], int V, int src) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
        placeHolderGo: "func dijkstra(graph [][]PairType, V, src int) []int {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
        spaceComplexity: "O(N)",
        timeComplexity: "O(E + V)logV",
        difficulty: "Medium",
        question: "Dijkstra",
        answerImage: "",
        answerCpp: `
typedef pair<int, int> PairType;

vector<int> dijkstra(vector<PairType>& graph[], int V, int src) {
    priority_queue<PairType, vector<PairType>, greater<PairType>> pq;
    vector<int> dist(V, INT_MAX);
    dist[src] = 0;
    pq.push({0, src});

    while (!pq.empty()) {
        int node = pq.top().second;
        pq.pop();

        for (auto nei : graph[node]) {
            int v = nei.first;
            int w = nei.second;

            if (dist[v] > dist[node] + w) {
                dist[v] = dist[node] + w;
                pq.push({dist[v], v});
            }
        }
    }
    return dist;
}`,
        answerGo: `
func dijkstra(graph [][]PairType, V, src int) []int {
	dist := make([]int, V)
	for i := range dist {
		dist[i] = math.MaxInt
	}
	dist[src] = 0

	pq := &PriorityQueue{}
	heap.Push(pq, PairType{0, src})

	for pq.Len() > 0 {
		node := heap.Pop(pq).(PairType).node

		for _, nei := range graph[node] {
			v := nei.node
			w := nei.distance

			if dist[v] > dist[node] + w {
				dist[v] = dist[node] + w
				heap.Push(pq, PairType{dist[v], v})
			}
		}
	}
	return dist
}`
    },
]