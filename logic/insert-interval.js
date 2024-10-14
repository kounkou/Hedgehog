var question = [
    {
        id: "17",
        category: "Intervals",
        placeHolderCpp: `vector<Interval> insertInterval(vector<Interval>& intervals, Interval newInterval) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: ``,
        difficulty: "Medium",
        question: "Insert interval",
        answerImage: "",
        answerCpp: `vector<Interval> insertInterval(vector<Interval>& intervals, Interval newInterval) {
    vector<Interval> result;
    int i = 0, n = intervals.size();

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
        answerGo: ``
    }
]
