var question = [
    {
        id: "Reverse list",
        category: "Linked List",
        placeHolderCpp: `ListNode* reverseLinkedList(ListNode* head) {\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        placeHolderGo: `{\n    ...\n}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n`,
        difficulty: "Easy",
        question: "Reverse linked list",
        answerImage: "",
        answerCpp: `ListNode* reverseLinkedList(ListNode* head) {
    ListNode* prev = nullptr;
    ListNode* curr = head;
    ListNode* next = nullptr;

    while (curr != nullptr) {
        next = curr->next;
        curr->next = prev;
        prev = curr;
        curr = next;
    }

    return prev;
}`,
        answerGo: ``
    }
]
