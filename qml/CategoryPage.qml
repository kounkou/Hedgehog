import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: categoryPage
    width: parent.width
    height: parent.height - 10
    property string theme: "light"
    color: themeObject.backgroundColor

    property var session: null
    property var selectedCategories: []
    property bool isCategorySelected: false

    ListModel {
        id: categoryModel
        ListElement { name: "Backtracking";         selected: false; enabled: false }
        ListElement { name: "BFS";                  selected: false; enabled: true }
        ListElement { name: "Binary Search";        selected: false; enabled: true }
        ListElement { name: "Bit Manipulation";     selected: false; enabled: false }
        ListElement { name: "Combinatorics";        selected: false; enabled: false }
        ListElement { name: "DFS";                  selected: false; enabled: true }
        ListElement { name: "Divide and Conquer";   selected: false; enabled: false }
        ListElement { name: "Disjoint Set";         selected: false; enabled: true }
        ListElement { name: "DP";                   selected: false; enabled: true }
        ListElement { name: "Fibonacci";            selected: false; enabled: false }
        ListElement { name: "Game Theory";          selected: false; enabled: false }
        ListElement { name: "Geometry";             selected: false; enabled: true }
        ListElement { name: "Greedy";               selected: false; enabled: false }
        ListElement { name: "Graph";                selected: false; enabled: true }
        ListElement { name: "Heap";                 selected: false; enabled: false }
        ListElement { name: "Intervals";            selected: false; enabled: true }
        ListElement { name: "Knapsack";             selected: false; enabled: false }
        ListElement { name: "Linked List";          selected: false; enabled: false }
        ListElement { name: "Mathematics";          selected: false; enabled: false }
        ListElement { name: "Pigeonhole Principle"; selected: false; enabled: false }
        ListElement { name: "Recursion";            selected: false; enabled: false }
        ListElement { name: "Searching";            selected: false; enabled: true }
        ListElement { name: "Segment Tree";         selected: false; enabled: false }
        ListElement { name: "Sieve Eratosthenes";   selected: false; enabled: false }
        ListElement { name: "Sliding Window";       selected: false; enabled: false }
        ListElement { name: "Sorting";              selected: false; enabled: false }
        ListElement { name: "String";               selected: false; enabled: true }
        ListElement { name: "Topological Sorting";  selected: false; enabled: false }
        ListElement { name: "Tree";                 selected: false; enabled: false }
        ListElement { name: "Trie";                 selected: false; enabled: false }
        ListElement { name: "Two Pointers";         selected: false; enabled: false }
        ListElement { name: "Union-Find";           selected: false; enabled: false }
    }

    ScrollView {
        width: parent.width / 1.5
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff

        Column {
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 10
            spacing: 20

            Rectangle {
                width: parent.width
                height: 50
                color: "transparent"
                radius: 15

                Text {
                    text: "Select algorithm categories"
                    font.pixelSize: 24
                    anchors.centerIn: parent
                    color: themeObject.textColor
                }
            }

            Flow {
                id: categoriesFlow
                width: parent.width
                spacing: 5

                Repeater {
                    model: categoryModel

                    delegate: Rectangle {
                        width: 150
                        height: 30
                        radius: 15
                        property bool isHovered: false
                        enabled: model.enabled
                        color: {
                            if (!model.enabled) {
                                opacity = 0.5
                            }
                            if (isHovered && !model.selected) {
                                return themeObject.buttonHoveredColor;
                            } else if (isHovered && model.selected || model.selected) {
                                return themeObject.buttonMediumColor;
                            } else {
                                return themeObject.buttonColor;
                            }
                        }

                        Text {
                            id: categoryText
                            text: model.name
                            font.pixelSize: 14
                            font.bold: true
                            color: themeObject.textColor
                            anchors.centerIn: parent
                        }

                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            hoverEnabled: true

                            onEntered: {
                                isHovered = true;
                            }

                            onExited: {
                                isHovered = false;
                            } 

                            onClicked: {
                                model.selected = !model.selected;

                                if (model.selected) {
                                    selectedCategories.push(model.name);
                                    session.selectedCategories = selectedCategories
                                    isCategorySelected = true
                                } else {
                                    const index = session.selectedCategories.indexOf(model.name);
                                    if (index > -1) {
                                        selectedCategories.splice(index, 1);
                                        session.selectedCategories = selectedCategories
                                    }
                                }

                                if (session.selectedCategories.length === 0) {
                                    isCategorySelected = false
                                }                               
                            }
                        }
                    }
                }
            }

            RowLayout {
                spacing: 20
                anchors.horizontalCenter: parent.horizontalCenter

                CustomButton {
                    id: startPractice

                    enabled: isCategorySelected
                    buttonText: "Start Practicing"
                    page: practicePage
                }

                CustomButton {
                    id: home

                    buttonText: "Close session"
                    page: welcomePage
                }
            }
        }
    }
}
