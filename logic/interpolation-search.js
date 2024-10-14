var interpolationSearchQuestions = [
    {
        id: "10",
        category: "Searching",
        placeHolderCpp: `int interpolationSearch(const std::vector<int>& arr, int target) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func interpolationSearch(nums []int, target int) int {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
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
`, answerGo: ``
    }
]
