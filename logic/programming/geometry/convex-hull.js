var question = [
    {
        id: "Convex hull",
        category: "Geometry",
        placeHolderCpp: `vector<Point> convexHull(vector<Point>& points) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func convexHull(points []Point) []Point {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        spaceComplexity: "O()",
        timeComplexity: "O()",
        difficulty: "Hard",
        question: "Convex Hull",
        answerImage: "",
        answerCpp: `

int orientation(Point p, Point q, Point r) {
    int val = (q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y);
    if (val == 0) return 0;
    return (val > 0) ? 1 : 2;
}

bool compare(Point p1, Point p2) {
    return (p1.x < p2.x) || (p1.x == p2.x && p1.y < p2.y);
}

vector<Point> convexHull(vector<Point>& points) {
    sort(points.begin(), points.end(), compare);
    vector<Point> hull;

    for (Point p : points) {
        while (hull.size() >= 2 && orientation(hull[hull.size()-2], hull.back(), p) != 2) {
            hull.pop_back();
        }
        hull.push_back(p);
    }

    size_t t = hull.size() + 1;
    for (int i = points.size() - 1; i >= 0; i--) {
        while (hull.size() >= t && orientation(hull[hull.size()-2], hull.back(), points[i]) != 2) {
            hull.pop_back();
        }
        hull.push_back(points[i]);
    }
    hull.pop_back();

    return hull;
}
`, answerGo: `func orientation(p, q, r Point) int {
    val := (q.Y - p.Y) * (r.X - q.X) - (q.X - p.X) * (r.Y - q.Y)
    if val == 0 {
        return 0
    }
    if val > 0 {
        return 1
    }
    return 2
}

func convexHull(points []Point) []Point {
    sort.Slice(points, func(i, j int) bool {
        if points[i].X == points[j].X {
            return points[i].Y < points[j].Y
        }
        return points[i].X < points[j].X
    })

    hull := []Point{}

    for _, p := range points {
        for len(hull) >= 2 && orientation(hull[len(hull)-2], hull[len(hull)-1], p) != 2 {
            hull = hull[:len(hull)-1]
        }
        hull = append(hull, p)
    }

    t := len(hull) + 1
    for i := len(points) - 1; i >= 0; i-- {
        p := points[i]
        for len(hull) >= t && orientation(hull[len(hull)-2], hull[len(hull)-1], p) != 2 {
            hull = hull[:len(hull)-1]
        }
        hull = append(hull, p)
    }
    hull = hull[:len(hull)-1]

    return hull
}`
    }
]
