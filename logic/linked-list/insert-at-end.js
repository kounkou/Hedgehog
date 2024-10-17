var question = [
    {
        id: "25",
        category: "Linked List",
        placeHolderCpp: `struct Node {\n    int data;\n    Node* next;\n};\n\nvoid insertAtEnd(Node** head, int newData) {\n    ...\n}\n\nvoid printList(Node* head) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `type Node struct {\n    data int\n    next *Node\n}\n\nfunc insertAtEnd(head **Node, newData int) {\n    ...\n}\n\nfunc printList(head *Node) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n`,
        difficulty: "Medium",
        question: "Insert and Print Linked List",
        answerImage: "",
        answerCpp: `struct Node {
    int data;
    Node* next;
};

void insertAtEnd(Node** head, int newData) {
    Node* newNode = new Node();
    newNode->data = newData;
    newNode->next = nullptr;

    if (*head == nullptr) {
        *head = newNode;
        return;
    }

    Node* temp = *head;
    while (temp->next != nullptr)
        temp = temp->next;

    temp->next = newNode;
}

void printList(Node* head) {
    while (head != nullptr) {
        cout << head->data << " ";
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
