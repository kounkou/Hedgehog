var question = [
    {
        id: "18",
        category: "Intervals",
        placeHolderCpp: `int minMeetingRooms(vector<Interval>& intervals) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: ``,
        spaceComplexity: "O()",
        timeComplexity: "O()",
        difficulty: "Medium",
        question: "Min meeting room",
        answerImage: "",
        answerCpp: `int minMeetingRooms(vector<Interval>& intervals) {
    vector<int> startTimes, endTimes;

    for (const auto& interval : intervals) {
        startTimes.push_back(interval.start);
        endTimes.push_back(interval.end);
    }

    sort(startTimes.begin(), startTimes.end());
    sort(endTimes.begin(), endTimes.end());

    int rooms = 0, j = 0;

    for (int i = 0; i < startTimes.size(); ++i) {
        if (startTimes[i] < endTimes[j]) {
            rooms++;
        } else {
            j++;
        }
    }

    return rooms;
}
`,
        answerGo: ``
    }
]
