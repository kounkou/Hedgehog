var question = [
    {
        id: "15",
        category: "Geometry",
        placeHolderCpp: `double areaOfTriangle(Point a, Point b, Point c) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: ``,
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
}`, answerGo: ``
    }
]
