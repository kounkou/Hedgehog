var question = [
    {
        id: "Triangle area",
        category: "Geometry",
        placeHolderCpp: `double areaOfTriangle(Point a, Point b, Point c) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func areaOfTriangle(a, b, c Point) float64 {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        spaceComplexity: "O()",
        timeComplexity: "O()",
        difficulty: "Medium",
        question: "Area triangle Heron",
        answerImage: "",
        answerCpp: `
double areaOfTriangle(Point a, Point b, Point c) {
    double s = (sqrt(pow(b.x - a.x, 2) + pow(b.y - a.y, 2)) + 
                 sqrt(pow(c.x - b.x, 2) + pow(c.y - b.y, 2)) + 
                 sqrt(pow(a.x - c.x, 2) + pow(a.y - c.y, 2))) / 2;
    return sqrt(s * (s - sqrt(pow(b.x - a.x, 2) + pow(b.y - a.y, 2))) * 
                (s - sqrt(pow(c.x - b.x, 2) + pow(c.y - b.y, 2))) * 
                (s - sqrt(pow(a.x - c.x, 2) + pow(a.y - c.y, 2))));
}`, answerGo: `func areaOfTriangle(a, b, c Point) float64 {
    sideAB := math.Sqrt(math.Pow(b.X-a.X, 2) + math.Pow(b.Y-a.Y, 2))
    sideBC := math.Sqrt(math.Pow(c.X-b.X, 2) + math.Pow(c.Y-b.Y, 2))
    sideCA := math.Sqrt(math.Pow(a.X-c.X, 2) + math.Pow(a.Y-c.Y, 2))
    
    s := (sideAB + sideBC + sideCA) / 2
    return math.Sqrt(s * (s - sideAB) * (s - sideBC) * (s - sideCA))
}`
    }
]
