import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: categoryPage
    width: parent.width
    height: parent.height - 10
    property string theme: "light"
    color: themeObject.backgroundColor

    property bool isCategorySelected: false
    property ListModel categoryModel: ListModel {}

    Component.onCompleted: {
        categoryModel.append({ name: "Backtracking",         selected: false, enabled: false });
        categoryModel.append({ name: "Graph",                selected: false, enabled: true });
        categoryModel.append({ name: "Binary Search",        selected: false, enabled: true });
        categoryModel.append({ name: "Bit Manipulation",     selected: false, enabled: false });
        categoryModel.append({ name: "Combinatorics",        selected: false, enabled: false });
        categoryModel.append({ name: "Divide and Conquer",   selected: false, enabled: false });
        categoryModel.append({ name: "Disjoint Set",         selected: false, enabled: true });
        categoryModel.append({ name: "DP",                   selected: false, enabled: true });
        categoryModel.append({ name: "Game Theory",          selected: false, enabled: false });
        categoryModel.append({ name: "Geometry",             selected: false, enabled: true });
        categoryModel.append({ name: "Greedy",               selected: false, enabled: true });
        categoryModel.append({ name: "Heap",                 selected: false, enabled: true });
        categoryModel.append({ name: "Intervals",            selected: false, enabled: true });
        categoryModel.append({ name: "Linked List",          selected: false, enabled: true });
        categoryModel.append({ name: "Mathematics",          selected: false, enabled: true });
        categoryModel.append({ name: "Pigeonhole",           selected: false, enabled: false });
        categoryModel.append({ name: "Recursion",            selected: false, enabled: true });
        categoryModel.append({ name: "Searching",            selected: false, enabled: true });
        categoryModel.append({ name: "Segment Tree",         selected: false, enabled: false });
        categoryModel.append({ name: "Sliding Window",       selected: false, enabled: false });
        categoryModel.append({ name: "Sorting",              selected: false, enabled: false });
        categoryModel.append({ name: "String",               selected: false, enabled: true });
        categoryModel.append({ name: "Topological Sorting",  selected: false, enabled: false });
        categoryModel.append({ name: "Tree",                 selected: false, enabled: false });
        categoryModel.append({ name: "Trie",                 selected: false, enabled: true });
        categoryModel.append({ name: "Two Pointers",         selected: false, enabled: false });
        categoryModel.append({ name: "Union-Find",           selected: false, enabled: false });
        categoryModel.append({ name: "Others",               selected: false, enabled: false });

        for (let i = 0; i < sessionObject.selectedCategories.length; i++) {
            let category = sessionObject.selectedCategories[i];

            for (let j = 0; j < categoryModel.count; j++) {
                if (categoryModel.get(j).name === category) {
                    categoryModel.setProperty(j, "selected", categoryModel.get(j).enabled);
                    isCategorySelected = true;
                }
            }
        }
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
                radius: 10

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
                        radius: 10
                        border.width: 1
                        border.color: themeObject.buttonBorderColor
                        property bool isHovered: false
                        enabled: model.enabled
                        color: {
                            if (!model.enabled) {
                                opacity = 0.5
                            }
                            if (isHovered && !model.selected) {
                                return themeObject.buttonHoveredColor;
                            } else if (isHovered && model.selected || model.selected) {
                                return themeObject.buttonActionColor;
                            } else {
                                return themeObject.categoryColor;
                            }
                        }

                        Text {
                            id: categoryText
                            text: model.enabled ? model.name : "🔒"
                            font.pixelSize: 14
                            font.bold: true
                            color: model.selected ? "#F7F7F7" : themeObject.textColor
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
                                    sessionObject.selectedCategories.push(model.name);
                                    isCategorySelected = true
                                } else {
                                    const index = sessionObject.selectedCategories.indexOf(model.name);
                                    if (index > -1) {
                                        sessionObject.selectedCategories.splice(index, 1);
                                    }
                                }

                                if (sessionObject.selectedCategories.length === 0) {
                                    isCategorySelected = false
                                }
                            }
                        }
                    }
                }
            }

            TextArea {
                id: infos
                width: parent.width
                height: 150
                font.family: "Courier New"
                font.pixelSize: 14
                font.bold: false
                color: themeObject.textColor
                textFormat: TextEdit.RichText
                readOnly: true
                text: ""
                padding: 10
                antialiasing: true
                wrapMode: Text.Wrap
                background: Rectangle {
                    color: "transparent"
                    border.width: 0
                    border.color: themeObject.textAreaBorderColor
                    radius: 10
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

                    buttonText: "Go to home"
                    page: welcomePage
                }
            }
        }
    }
}
