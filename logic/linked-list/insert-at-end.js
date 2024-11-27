var question = [
    {
        id: "Insert at end",
        category: "Linked List",
        placeHolderCpp: `struct ListNode {\n    int data;\n    ListNode* next;\n};\n\nvoid insertAtEnd(ListNode** head, int v) {\n    ...\n}\n\nvoid printList(ListNode* head) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `type Node struct {\n    data int\n    next *Node\n}\n\nfunc insertAtEnd(head **Node, newData int) {\n    ...\n}\n\nfunc printList(head *Node) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n`,
        difficulty: "Medium",
        question: "Insert and Print Linked List",
        answerImage: "",
        answerCpp: `struct ListNode {
    int val;
    ListNode* next;
    ListNode(int v) : val(v), next(nullptr) {}
};

void insertAtEnd(ListNode** head, int v) {
    ListNode* dummy = new ListNode(v);

    if (*head == nullptr) {
        *head = dummy;
        return;
    }

    ListNode* temp = *head;
    
    while (temp->next != nullptr) {
        temp = temp->next;
    }

    temp->next = dummy;
}

void printList(ListNode* head) {
    while (head != nullptr) {
        cout << head->val << " ";
        head = head->next;
    }
}`,
        answerGo: `package main

import "fmt"

type Node struct {
    data int
    next *Node
}

func insertAtEnd(head **Node, newData int) {
    newNode := &Node{data: newData, next: nil}

    if *head == nil {
        *head = newNode
        return
    }

    temp := *head
    for temp.next != nil {
        temp = temp.next
    }

    temp.next = newNode
}

func printList(head *Node) {
    for head != nil {
        fmt.Printf("%d ", head.data)
        head = head.next
    }
}`
    }
]
