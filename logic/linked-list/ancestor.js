var question = [
    {
        id: "Ancestor",
        category: "Linked List",
        placeHolderCpp: `ListNode* findAncestor(ListNode* head, int target) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func findAncestor(head *ListNode, target int) *ListNode {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        difficulty: "Medium",
        question: "Find the Ancestor Element in Linked List",
        answerImage: "",
        answerCpp: `struct ListNode {
    int val;
    ListNode* next;
    ListNode(int x) : val(x), next(nullptr) {}
};

ListNode* findAncestor(ListNode* head, int v) {
    ListNode* prev = nullptr;

    while (head != nullptr) {
        if (head->val == v) {
            return prev;
        }
        prev = head;
        head = head->next;
    }
    
    return nullptr;
}`,
        answerGo: `type ListNode struct {
    Val  int
    Next *ListNode
}

func findAncestor(head *ListNode, target int) *ListNode {
    var prev *ListNode

    for head != nil {
        if head.Val == target {
            return prev
        }
        prev = head
        head = head.Next
    }
    
    return nil
}`
    }
]
