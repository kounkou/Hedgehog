var question = [
    {
        id: "subsets",
        category: "Combinatorics",
        placeHolderCpp: `void generateSubsets(const vector<int>& nums, int index, vector<int>& current, vector<vector<int>>& result) {\n    // Recursive function to generate all subsets of a set\n    ...\n}\n`,
        placeHolderGo: `func generateSubsets(nums []int, index int, current []int, result *[][]int) {\n    // Recursive function to generate all subsets of a set\n    ...\n}\n`,
        difficulty: "Hard",
        question: "Generate all subsets of a given set of integers.",
        answerImage: "",
        answerCpp: `void generateSubsets(const vector<int>& nums, int index, vector<int>& current, vector<vector<int>>& result) {
    if (index == nums.size()) {
        result.push_back(current);
        return;
    }
    
    generateSubsets(nums, index + 1, current, result);
    current.push_back(nums[index]);
    generateSubsets(nums, index + 1, current, result);
    current.pop_back();
}`,
        answerGo: `func generateSubsets(nums []int, index int, current []int, result *[][]int) {
    if index == len(nums) {
        subset := make([]int, len(current))
        copy(subset, current)
        *result = append(*result, subset)
        return
    }

    generateSubsets(nums, index+1, current, result)
    current = append(current, nums[index])
    generateSubsets(nums, index+1, current, result)
    current = current[:len(current)-1]
}`
    }
]