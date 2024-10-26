var question = [
    {
        id: "Insert heap",
        category: "Heap",
        placeHolderCpp: `void heapifyUp(vector<int>& heap, int index) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func heapifyUp(heap []int, index int) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        difficulty: "Easy",
        question: "Insert an element into a Max Heap.",
        answerImage: "",
        answerCpp: `void heapifyUp(vector<int>& heap, int index) {
    int parent = (index - 1) / 2;
    if (parent >= 0 && heap[parent] < heap[index]) {
        swap(heap[parent], heap[index]);
        heapifyUp(heap, parent);
    }
}

void insertMaxHeap(vector<int>& heap, int value) {
    heap.push_back(value);
    heapifyUp(heap, heap.size() - 1);
}`,
        answerGo: `func heapifyUp(heap []int, index int) {
    parent := (index - 1) / 2
    if parent >= 0 && heap[parent] < heap[index] {
        heap[parent], heap[index] = heap[index], heap[parent]
        heapifyUp(heap, parent)
    }
}

func insertMaxHeap(heap *[]int, value int) {
    *heap = append(*heap, value)
    heapifyUp(*heap, len(*heap)-1)
}
`
    }
]
