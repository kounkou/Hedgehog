var question = [
    {
        id: "Meeting rooms",
        category: "Intervals",
        placeHolderCpp: `int minMeetingRooms(vector<Interval>& intervals) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func minMeetingRooms(intervals [][]int) int {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
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
        answerGo: `type Interval struct {
    start int
    end   int
}

func minMeetingRooms(intervals []Interval) int {
    startTimes := make([]int, 0)
    endTimes   := make([]int, 0)

    for _, v := range intervals {
        startTimes = append(startTimes, v.start)
        endTimes = append(endTimes, v.end)
    }

    sort.Slice(startTimes, func(i, j int) bool {
        return startTimes[i] > startTimes[j]
    })

    sort.Slice(endTimes, func(i, j int) bool {
        return endTimes[i] > endTimes[j]
    })

    rooms := 0
    j := 0

    for i := 0; i < len(startTimes); i++ {
        if startTimes[i] < endTimes[j] {
            rooms++
        } else {
            j++
        }
    }

    return rooms
}`
    }
]
