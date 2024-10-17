var question = [
    {
        id: "26",
        category: "Linked List",
        placeHolderCpp: `ListNode* removeElements(ListNode* head, int val) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func removeElements(head *ListNode, val int) *ListNode {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        difficulty: "Medium",
        question: "Remove all elements from a linked list that have a specific value.",
        answerImage: "",
        answerCpp: `struct ListNode {
    int val;
    ListNode* next;
    ListNode(int x) : val(x), next(NULL) {}
};

ListNode* removeElements(ListNode* head, int val) {
    ListNode* dummy = new ListNode(0);
    dummy->next = head;
    ListNode* prev = dummy;
    ListNode* curr = head;

    while (curr != NULL) {
        if (curr->val == val) {
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
