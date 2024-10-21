var question = [
    {
        id: "34",
        category: "Sliding Window",
        placeHolderCpp: `int maxSumSubarray(const vector<int>& arr, int k) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func maxSumSubarray(arr []int, k int) int {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        difficulty: "Medium",
        question: "find the maximum sum of a subarray of size `K`.",
        answerImage: "",
        answerCpp: `int maxSumSubarray(const vector<int>& arr, int k) {
    int maxSum = 0, windowSum = 0;
    
    for (int i = 0; i < k; i++) {
        windowSum += arr[i];
    }
    maxSum = windowSum;

    for (int i = k; i < arr.size(); i++) {
        windowSum += arr[i] - arr[i - k];
        maxSum = max(maxSum, windowSum);
    }

    return maxSum;
}`,
        answerGo: `func maxSumSubarray(arr []int, k int) int {
    windowSum, maxSum := 0, 0

    for i := 0; i < k; i++ {
        windowSum += arr[i]
    }
    maxSum = windowSum

    for i := k; i < len(arr); i++ {
        windowSum += arr[i] - arr[i-k]
        if windowSum > maxSum {
            maxSum = windowSum
        }
    }

    return maxSum
}`
    }
]
