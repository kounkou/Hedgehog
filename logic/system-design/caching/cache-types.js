var question = [
    {
        id: "Cache Types",
        category: "Cache",
        placeHolderCpp: ``,
        placeHolderGo: ``,
        difficulty: "Easy",
        question: "Different types of caches",
        answerImage: "",
        answerCpp: `
- Application server cache
    - If behind a Load Balancer with random hashing, the same request will go to different nodes
- Distributed cache
    - cache divided using consistent hashing
- Global cache
    - Cache manages eviction policy
    - Servers manage eviction policy
`
    }
]
