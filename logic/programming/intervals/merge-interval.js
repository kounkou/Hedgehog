var question = [
    {
        id: "Merge int.",
        category: "Intervals",
        placeHolderCpp: `vector<Interval> mergeIntervals(vector<Interval>& intervals) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func mergeIntervals(intervals []Interval) []Interval {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        spaceComplexity: "O(N)",
        timeComplexity: "O(NlogN)",
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

    for (int i = 1; i < intervals.size(); ++i) {
        if (merged.back().end >= intervals[i].start) {
            merged.back().end = max(merged.back().end, intervals[i].end);
        } else {
            merged.push_back(intervals[i]);
        }
    }

    return merged;
}`,
        answerGo: `func mergeIntervals(intervals[]Interval)[]Interval {
    if len(intervals) == 0 {
        return nil
    }

    sort.Slice(intervals, func(i, j int) bool {
        return intervals[i].Start < intervals[j].Start
    })

    merged:= []Interval{ intervals[0] }

    for i := 1; i < len(intervals); i++ {
        lastMerged:= & merged[len(merged) - 1]

        if lastMerged.End >= intervals[i].Start {
            lastMerged.End = max(lastMerged.End, intervals[i].End)
        } else {
            merged = append(merged, intervals[i])
        }
    }

    return merged
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
} `
    }
]
