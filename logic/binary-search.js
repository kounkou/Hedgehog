var binarySearchQuestions = [
    {
        id: "5",
        category: "Binary Search",
        placeHolderCpp: "int binarySearch(vector<int>& nums, int t) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
        placeHolderGo: "func binarySearch(nums []int, t int) int {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
        spaceComplexity: "O(1)",
        timeComplexity: "O(logN)",
        difficulty: "Easy", question: "Binary search",
        answerImage: "../code-snipets/binary_search.png",
        answerCpp: `int binarySearch(vector<int>& nums, int t) {
    int n = nums.size();
    int lo = 0;
    int hi = n - 1;

    while (lo <= hi) {
        int mi = lo + ((hi - lo) >> 1);
        if (nums[mi] == t) {
            return mi;
        } else if (nums[mi] > t) {
            hi = mi - 1;
        } else {
            lo = mi + 1;
        }
    }

    return -1;
}`,
        answerGo: `func binarySearch(nums []int, t int) int {
	lo := 0
	hi := len(nums) - 1

	for lo <= hi {
		mi := lo + (hi-lo)/2

		if nums[mi] == t {
			return mi
		} else if nums[mi] > t {
			hi = mi - 1
		} else {
			lo = mi + 1
		}
	}

	return -1
}
`}
]