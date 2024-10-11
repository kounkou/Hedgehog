var kadaneQuestions = [
    {
        id: "7",
        placeHolderCpp: `void kadane(int start) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func kadane(start int) {{\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        difficulty: "Medium",
        question: "Maximum subarray sum (Kadane's Algorithm)",
        answerImage: "../code-snipets/kadane.png",
        answerCpp: `
int kadane(vector<vector<int>>& nums) {
    if (nums.size() <= 0) return 0; 
    int lm = nums[0], gm = INT_MIN;
    
    for (int i = 0; i < nums.size(); ++i) {
        lm = max(nums[i], nums[i] + lm);
        gm = max(gm, lm);
    }
    
    return gm;
}`, answerGo: `undefined`
    }
]
