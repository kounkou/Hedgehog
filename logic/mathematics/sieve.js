var question = [
    {
        id: "22",
        category: "Mathematics",
        placeHolderCpp: `void sieveOfEratosthenes(int n) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func sieveOfEratosthenes(n int) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        difficulty: "Medium",
        question: "Sieve of Eratosthenes",
        answerImage: "",
        answerCpp: `void sieveOfEratosthenes(int n) {
    vector<bool> isPrime(n + 1, true);
    isPrime[0] = isPrime[1] = false;

    for (int i = 2; i * i <= n; i++) {
        if (isPrime[i]) {
            for (int j = i * i; j <= n; j += i)
                isPrime[j] = false;
        }
    }

    for (int i = 2; i <= n; i++) {
        if (isPrime[i])
            cout << i << " ";
    }
}`,
        answerGo: `package main

import "fmt"

func sieveOfEratosthenes(n int) {
    isPrime := make([]bool, n+1)
    
    for i := 2; i <= n; i++ {
        isPrime[i] = true
    }

    for i := 2; i*i <= n; i++ {
        if isPrime[i] {
            for j := i * i; j <= n; j += i {
                isPrime[j] = false
            }
        }
    }

    for i := 2; i <= n; i++ {
        if isPrime[i] {
            fmt.Print(i, " ")
        }
    }
    fmt.Println()
}

func main() {
    sieveOfEratosthenes(30)
}`
    }
]
