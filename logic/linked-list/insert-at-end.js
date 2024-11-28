var question = [
    {
        id: "Insert at end",
        category: "Linked List",
        placeHolderCpp: `void insertAtEnd(ListNode** head, int v) {\n    ...\n}\n\nvoid printList(ListNode* head) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `func insertAtEnd(head **Node, newData int) {\n    ...\n}\n\nfunc printList(head *Node) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n`,
        difficulty: "Medium",
        question: "Insert at Linked List end",
        answerImage: "",
        answerCpp: `void insertAtEnd(ListNode** head, int v) {
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
