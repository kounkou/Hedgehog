var question = [
    {
        id: "unique paths",
        category: "Combinatorics",
        placeHolderCpp: `int uniquePaths(int m, int n) {\n    // Number of unique paths in an m x n grid\n    int paths = ...\n}\n`,
        placeHolderGo: `func uniquePaths(m int, n int) int {\n    // Number of unique paths in an m x n grid\n    paths := ...\n}\n`,
        difficulty: "Hard",
        question: "top-left to the bottom-right unique paths",
        answerImage: "",
        answerCpp: `int uniquePaths(int m, int n) {
    int paths[m][n];
    
    for (int i = 0; i < m; i++) paths[i][0] = 1;
    for (int j = 0; j < n; j++) paths[0][j] = 1;
    for (int i = 1; i < m; i++) {
        for (int j = 1; j < n; j++) {
            paths[i][j] = paths[i - 1][j] + paths[i][j - 1];
        }
    }
    
    return paths[m - 1][n - 1];
}`,
        answerGo: `func uniquePaths(m int, n int) int {
    paths := make([][]int, m)
    
    for i := range paths {
        paths[i] = make([]int, n)
    }
    
    for i := 0; i < m; i++ {
        paths[i][0] = 1
    }
    for j := 0; j < n; j++ {
        paths[0][j] = 1
    }
    for i := 1; i < m; i++ {
        for j := 1; j < n; j++ {
            paths[i][j] = paths[i-1][j] + paths[i][j-1]
        }
    }
    
    return paths[m-1][n-1]
}`
    }
]