var question = [
    {
        id: "34",
        category: "Sliding Window",
        placeHolderCpp: `int maxSumSubArray(vector<int>& nums, int k) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func maxSumSubArray(arr []int, k int) int {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        difficulty: "Medium",
        question: "find the maximum sum of a subarray of size `K`.",
        answerImage: "",
        answerCpp: `int maxSumSubArray(vector<int>& nums, int k) {
    int maxSum = 0, windowSum = 0;
    
    for (int i = 0; i < k; ++i) {
        windowSum += nums[i];
    }
    
    maxSum = windowSum;

    for (int i = k; i < nums.size(); ++i) {
        windowSum += nums[i] - nums[i - k];
        maxSum = max(maxSum, windowSum);
    }

    return maxSum;
}`,
        answerGo: `func maxSumSubArray(nums []int, k int) int {
    windowSum, maxSum := 0, 0

    for i := 0; i < k; i++ {
        windowSum += nums[i]
    }
    
    maxSum = windowSum

    for i := k; i < len(nums); i++ {
        windowSum += nums[i] - nums[i-k]
        
        if windowSum > maxSum {
            maxSum = windowSum
        }
    }

    return maxSum
}`
    }
]
