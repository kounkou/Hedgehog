var question = [
    {
        id: "21",
        category: "Greedy",
        placeHolderCpp: `double fractionalKnapsack(int W, vector<Item>& items) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func fractionalKnapsack(W int, items []Item) float64 {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        difficulty: "Medium",
        question: "Fractional Knapsack",
        answerImage: "",
        answerCpp: `double fractionalKnapsack(int W, vector<Item>& items) {
    sort(items.begin(), items.end());

    double totalValue = 0.0;

    for (const auto& item : items) {
        if (W >= item.weight) {
            totalValue += item.value;
            W -= item.weight;
        } else {
            totalValue += item.value * ((double)W / item.weight);
            break;
        }
    }

    return totalValue;
}
`,
        answerGo: `type Item struct {
    Weight int
    Value  int
}

func fractionalKnapsack(W int, items []Item) float64 {
    sort.Slice(items, func(i, j int) bool {
        return float64(items[i].Value)/float64(items[i].Weight) > float64(items[j].Value)/float64(items[j].Weight)
    })

    totalValue := 0.0

    for _, item := range items {
        if W >= item.Weight {
            totalValue += float64(item.Value)
            W -= item.Weight
        } else {
            totalValue += float64(item.Value) * (float64(W) / float64(item.Weight))
            break
        }
    }

    return totalValue
}`
    }
]
