var jumpSearchQuestions = [
    {
        id: "11",
        category: "Searching",
        placeHolderCpp: `int jumpSearch(const vector<int>& nums, int target) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func jumpSearch(nums []int, target int) int {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        spaceComplexity: "O()",
        timeComplexity: "O()",
        difficulty: "Easy",
        question: "Jump search",
        answerImage: "",
        answerCpp: `
int jumpSearch(const vector<int>& arr, int target) {
    int n = arr.size();
    int step = sqrt(n);
    int prev = 0;

    while (arr[min(step, n) - 1] < target) {
        prev = step;
        step += sqrt(n);
        
        if (prev >= n) {
            return -1;
        }
    }

    for (int i = prev; i < min(step, n); ++i) {
        if (arr[i] == target) {
            return i;
        }
    }
    return -1;
}`, answerGo: ``
    }
]
