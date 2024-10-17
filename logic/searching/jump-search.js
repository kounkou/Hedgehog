var question = [
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
}`, answerGo: `func jumpSearch(nums []int, target int) int {
    n := len(nums)
    step := int(math.Sqrt(float64(n)))
    prev := 0

    for nums[min(step, n)-1] < target {
        prev = step
        step += int(math.Sqrt(float64(n)))

        if prev >= n {
            return -1
        }
    }

    for i := prev; i < min(step, n); i++ {
        if nums[i] == target {
            return i
        }
    }
    return -1
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}`
    }
]
