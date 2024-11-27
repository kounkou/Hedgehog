var question = [
    {
        id: "Remove element",
        category: "Linked List",
        placeHolderCpp: `struct ListNode {\n    int data;\n    ListNode* next;\n};\n\nListNode* removeElements(ListNode* head, int t) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func removeElements(head *ListNode, val int) *ListNode {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        difficulty: "Medium",
        question: "Remove all elements from a linked list that have a specific value.",
        answerImage: "",
        answerCpp: `struct ListNode {
    int val;
    ListNode* next;
    ListNode(int v) : val(v), next(nullptr) {}
};

ListNode* removeElements(ListNode* head, int t) {
    ListNode* dummy = new ListNode(0);
    dummy->next = head;
    ListNode* prev = dummy;
    ListNode* curr = head;

    while (curr != nullptr) {
        if (curr->val == t) {
            prev->next = curr->next;
        } else {
            prev = curr;
        }
        curr = curr->next;
    }

    return dummy->next;
}`,
        answerGo: `package main

import "fmt"

type ListNode struct {
    Val  int
    Next *ListNode
}

func removeElements(head *ListNode, val int) *ListNode {
    dummy := &ListNode{Next: head}
    prev := dummy
    curr := head

    for curr != nil {
        if curr.Val == val {
            prev.Next = curr.Next
        } else {
            prev = curr
        }
        curr = curr.Next
    }

    return dummy.Next
}

func printList(head *ListNode) {
    for head != nil {
        fmt.Print(head.Val, " ")
        head = head.Next
    }
    fmt.Println()
}`
    }
]
