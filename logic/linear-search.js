var linearSearchQuestions = [
    {
        id: "12",
        category: "Searching",
        placeHolderCpp: `int linearSearch(const vector<int>& nums, int target) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func linearSearch(nums []int, target int) int {{\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        difficulty: "Easy",
        question: "Linear search",
        answerImage: "",
        answerCpp: `
int linearSearch(const vector<int>& nums, int target) {
    for (int i = 0; i < nums.size(); ++i) {
        if (nums[i] == target) {
            return i;
        }
    }
    return -1;
}`, answerGo: `
func linearSearch(nums []int, target int) int {
    for i := 0; i < len(nums); i++ {
        if nums[i] == target {
            return i
        }
    }

    return -1
}
`}
]
