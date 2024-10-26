var question = [
    {
        id: "Interpolation search",
        category: "Searching",
        placeHolderCpp: `int interpolationSearch(const std::vector<int>& arr, int target) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func interpolationSearch(nums []int, target int) int {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        spaceComplexity: "O()",
        timeComplexity: "O()",
        difficulty: "Easy",
        question: "Interpolation search",
        answerImage: "",
        answerCpp: `
int interpolationSearch(const vector<int>& arr, int t) {
    int n = arr.size();
    int lo = 0;
    int hi = n - 1;

    while (lo <= hi && t >= arr[lo] && t <= arr[hi]) {
        int pos = lo + ((double)(hi - lo) / (arr[hi] - arr[lo]) * (t - arr[lo]));

        if (arr[pos] == t) {
            return pos;
        }
        if (arr[pos] < t) {
            lo = pos + 1;
        } else {
            hi = pos - 1;
        }
    }

    return -1;
}
`, answerGo: `func interpolationSearch(nums []int, target int) int {
    n := len(nums)
    lo, hi := 0, n-1

    for lo <= hi && target >= nums[lo] && target <= nums[hi] {
        if nums[hi] == nums[lo] {
            if nums[lo] == target {
                return lo
            }
            return -1
        }

        pos := lo + (hi-lo)*(target-nums[lo])/(nums[hi]-nums[lo])

        if nums[pos] == target {
            return pos
        }
        if nums[pos] < target {
            lo = pos + 1
        } else {
            hi = pos - 1
        }
    }

    return -1
}`
    }
]
