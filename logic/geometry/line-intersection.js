var question = [
    {
        id: "line inters.",
        category: "Geometry",
        placeHolderCpp: `bool doIntersect(Point p1, Point q1, Point p2, Point q2) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func doIntersect(p1, q1, p2, q2 Point) bool {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        spaceComplexity: "O()",
        timeComplexity: "O()",
        difficulty: "Easy",
        question: "Line intersection",
        answerImage: "",
        answerCpp: `bool onSegment(Point p, Point q, Point r) {
    return (q.x <= std::max(p.x, r.x) && q.x >= std::min(p.x, r.x) &&
            q.y <= std::max(p.y, r.y) && q.y >= std::min(p.y, r.y));
}

int orientation(Point p, Point q, Point r) {
    int val = (q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y);
    if (val == 0) return 0;
    return (val > 0) ? 1 : 2;
}

bool doIntersect(Point p1, Point q1, Point p2, Point q2) {
    int o1 = orientation(p1, q1, p2);
    int o2 = orientation(p1, q1, q2);
    int o3 = orientation(p2, q2, p1);
    int o4 = orientation(p2, q2, q1);
    
    if (o1 != o2 && o3 != o4)
        return true;

    if (o1 == 0 && onSegment(p1, p2, q1)) return true;
    if (o2 == 0 && onSegment(p1, q2, q1)) return true;
    if (o3 == 0 && onSegment(p2, p1, q2)) return true;
    if (o4 == 0 && onSegment(p2, q1, q2)) return true;

    return false;
}`, answerGo: `func onSegment(p, q, r Point) bool {
    return (q.X <= max(p.X, r.X) && q.X >= min(p.X, r.X) &&
            q.Y <= max(p.Y, r.Y) && q.Y >= min(p.Y, r.Y))
}

func orientation(p, q, r Point) int {
    val := (q.Y - p.Y) * (r.X - q.X) - (q.X - p.X) * (r.Y - q.Y)
    if val == 0 {
        return 0
    }
    if val > 0 {
        return 1
    }
    return 2
}

func doIntersect(p1, q1, p2, q2 Point) bool {
    o1 := orientation(p1, q1, p2)
    o2 := orientation(p1, q1, q2)
    o3 := orientation(p2, q2, p1)
    o4 := orientation(p2, q2, q1)

    if o1 != o2 && o3 != o4 {
        return true
    }

    if o1 == 0 && onSegment(p1, p2, q1) {
        return true
    }
    if o2 == 0 && onSegment(p1, q2, q1) {
        return true
    }
    if o3 == 0 && onSegment(p2, p1, q2) {
        return true
    }
    if o4 == 0 && onSegment(p2, q1, q2) {
        return true
    }

    return false
}`
    }
]
