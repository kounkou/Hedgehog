var question = [
    {
        id: "16",
        category: "Intervals",
        placeHolderCpp: `vector<Interval> mergeIntervals(vector<Interval>& intervals) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: ``,
        difficulty: "Medium",
        question: "Merge intervals",
        answerImage: "",
        answerCpp: `vector<Interval> mergeIntervals(vector<Interval>& intervals) {
    if (intervals.empty()) return {};
    
    sort(intervals.begin(), intervals.end(), [](Interval a, Interval b) {
        return a.start < b.start; 
    });

    vector<Interval> merged;
    
    merged.push_back(intervals[0]);
    
    for (int i = 1; i < intervals.size(); i++) {
        if (merged.back().end >= intervals[i].start) {
            merged.back().end = max(merged.back().end, intervals[i].end);
        } else {
            merged.push_back(intervals[i]);
        }
    }
    
    return merged;
}`,
        answerGo: ``
    }
]
