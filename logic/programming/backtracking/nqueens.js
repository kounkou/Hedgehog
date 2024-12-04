var question = [
    {
        id: "N queens",
        category: "Backtracking",
        placeHolderCpp: `void solveNQueens(int row, vector<string> &board, vector<vector<string>> &solutions, int n) {\n    ...\n};\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func solveNQueens(n int)[][]string { \n    ...\n }; \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        difficulty: "Hard",
        question: "Solve the N-Queens Problem",
        answerImage: "",
        answerCpp: `void solveNQueens(int row, vector<string> &board, vector<vector<string>> &solutions, int n) {
    if (row == n) {
        solutions.push_back(board);
        return;
    }

    for (int col = 0; col < n; ++col) {
        if (isSafe(row, col, board, n)) {
            board[row][col] = 'Q';
            solveNQueens(row + 1, board, solutions, n);
            board[row][col] = '.';
        }
    }
}

bool isSafe(int row, int col, vector<string> &board, int n) {
    for (int i = 0; i < row; ++i) {
        if (board[i][col] == 'Q') return false;
    }

    for (int i = row - 1, j = col - 1; i >= 0 && j >= 0; --i, --j) {
        if (board[i][j] == 'Q') return false;
    }

    for (int i = row - 1, j = col + 1; i >= 0 && j < n; --i, ++j) {
        if (board[i][j] == 'Q') return false;
    }

    return true;
}
`,
        answerGo: `func solveNQueens(n int) [][]string {
    board := make([][]string, n)
    for i := range board {
        board[i] = make([]string, n)
        for j := range board[i] {
            board[i][j] = "."
        }
    }
    solutions := [][]string{}
    solve(0, n, &board, &solutions)
    return solutions
}

func solve(row, n int, board *[][]string, solutions *[][]string) {
    if row == n {
        solution := make([]string, n)
        for i := 0; i < n; i++ {
            solution[i] = strings.Join((*board)[i], "")
        }
        *solutions = append(*solutions, solution)
        return
    }

    for col := 0; col < n; col++ {
        if isSafe(row, col, *board, n) {
            (*board)[row][col] = "Q"
            solve(row+1, n, board, solutions)
            (*board)[row][col] = "."
        }
    }
}

func isSafe(row, col int, board [][]string, n int) bool {
    for i := 0; i < row; i++ {
        if board[i][col] == "Q" {
            return false
        }
    }

    for i, j := row-1, col-1; i >= 0 && j >= 0; i, j = i-1, j-1 {
        if board[i][j] == "Q" {
            return false
        }
    }

    for i, j := row-1, col+1; i >= 0 && j < n; i, j = i-1, j+1 {
        if board[i][j] == "Q" {
            return false
        }
    }

    return true
}`
    }
]
