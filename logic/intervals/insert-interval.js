var question = [
    {
        id: "Insert int.",
        category: "Intervals",
        placeHolderCpp: `vector<Interval> insertInterval(vector<Interval>& intervals, Interval newInterval) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func insertInterval(intervals []Interval, newInterval Interval) []Interval {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        spaceComplexity: "O(N)",
        timeComplexity: "O(N)",
        difficulty: "Medium",
        question: "Insert interval",
        answerImage: "",
        answerCpp: `vector<Interval> insertInterval(vector<Interval>& intervals, Interval newInterval) {
    vector<Interval> result;
    int i = 0;
    int n = intervals.size();

    while (i < n && intervals[i].end < newInterval.start) {
        result.push_back(intervals[i++]);
    }

    while (i < n && intervals[i].start <= newInterval.end) {
        newInterval.start = min(newInterval.start, intervals[i].start);
        newInterval.end = max(newInterval.end, intervals[i].end);
        i++;
    }

    result.push_back(newInterval);

    while (i < n) {
        result.push_back(intervals[i++]);
    }

    return result;
}`,
        answerGo: `func insertInterval(intervals []Interval, newInterval Interval) []Interval {
    result := []Interval{}
    i := 0
    n := len(intervals)

    for i < n && intervals[i].End < newInterval.Start {
        result = append(result, intervals[i])
        i++
    }

    for i < n && intervals[i].Start <= newInterval.End {
        newInterval.Start = min(newInterval.Start, intervals[i].Start)
        newInterval.End = max(newInterval.End, intervals[i].End)
        i++
    }

    result = append(result, newInterval)

    for i < n {
        result = append(result, intervals[i])
        i++
    }

    return result
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}`
    }
]
