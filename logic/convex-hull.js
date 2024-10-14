var question = [
    {
        id: "13",
        category: "Geometry",
        placeHolderCpp: `vector<Point> convexHull(vector<Point>& points) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: ``,
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
`, answerGo: ``
    }
]
