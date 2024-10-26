var question = [
    {
        id: "kadane",
        category: "DP",
        placeHolderCpp: `int kadane(vector<int>& nums) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func kadane(nums []int) int {{\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        spaceComplexity: "O()",
        timeComplexity: "O()",
        difficulty: "Medium",
        question: "Maximum subarray sum (Kadane's Algorithm)",
        answerImage: "../code-snipets/kadane.png",
        answerCpp: `
int kadane(vector<int>& nums) {
    if (nums.size() <= 0) return 0; 
    
    int lm = nums[0];
    int gm = INT_MIN;
    
    for (int i = 0; i < nums.size(); ++i) {
        lm = max(nums[i], nums[i] + lm);
        gm = max(gm, lm);
    }
    
    return gm;
}`, answerGo: `
func kadane(nums []int) int {
    if len(nums) == 0 {
        return 0
    }

    lm := nums[0]
    gm := math.MinInt32

    for i := 1; i < len(nums); i++ {
        lm = max(nums[i], nums[i] + lm)
        gm = max(lm, gm)
    }

    return gm
}
`
    }
]
