var question = [
    {
        id: "Pigeon hole",
        category: "Pigeonhole Principle",
        placeHolderCpp: `int birthdayParadox() {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func birthdayParadox() int {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        difficulty: "Easy",
        question: "Minimum People with 50% chance 2 people have same birthday.",
        answerImage: "",
        answerCpp: `int birthdayParadox() {
    int days = 365;
    double prob = 1.0;
    int people = 0;

    while (prob > 0.5) {
        people++;
        prob *= (days - people) / static_cast<double>(days);
    }

    return people;
}
`,
        answerGo: `func birthdayParadox() int {
    days := 365.0
    prob := 1.0
    people := 0

    for prob > 0.5 {
        people++
        prob *= (days - float64(people)) / days
    }

    return people
}
`
    }
]
