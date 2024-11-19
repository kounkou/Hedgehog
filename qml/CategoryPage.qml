import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: categoryPage
    width: parent.width
    height: parent.height
    property string theme: "light"
    property string currentTopic: "Computer Science"

    color: themeObject.backgroundColor

    property bool isCategorySelected: false
    property ListModel categoryModel: ListModel {}

    Component.onCompleted: {
    }

    QtObject {
        id: d

        function updateComputerScienceModel() {
            categoryModel.clear();

            categoryModel.append({ name: "Backtracking",         selected: false, enabled: true,  type: "Programming" });
            categoryModel.append({ name: "Graph",                selected: false, enabled: true,  type: "Programming" });
            categoryModel.append({ name: "Binary Search",        selected: false, enabled: true,  type: "Programming" });
            categoryModel.append({ name: "Bit Manipulation",     selected: false, enabled: true,  type: "Programming" });
            categoryModel.append({ name: "Combinatorics",        selected: false, enabled: true,  type: "Programming" });
            categoryModel.append({ name: "Div. Conq.",           selected: false, enabled: true,  type: "Programming" });
            categoryModel.append({ name: "Disjoint Set",         selected: false, enabled: true,  type: "Programming" });
            categoryModel.append({ name: "DP",                   selected: false, enabled: true,  type: "Programming" });
            categoryModel.append({ name: "Game Theory",          selected: false, enabled: false, type: "Programming" });
            categoryModel.append({ name: "Geometry",             selected: false, enabled: true,  type: "Programming" });
            categoryModel.append({ name: "Greedy",               selected: false, enabled: true,  type: "Programming" });
            categoryModel.append({ name: "Heap",                 selected: false, enabled: true,  type: "Programming" });
            categoryModel.append({ name: "Intervals",            selected: false, enabled: true,  type: "Programming" });
            categoryModel.append({ name: "Linked List",          selected: false, enabled: true,  type: "Programming" });
            categoryModel.append({ name: "Mathematics",          selected: false, enabled: true,  type: "Programming" });
            categoryModel.append({ name: "Pigeonhole",           selected: false, enabled: false, type: "Programming" });
            categoryModel.append({ name: "Recursion",            selected: false, enabled: true,  type: "Programming" });
            categoryModel.append({ name: "Searching",            selected: false, enabled: true,  type: "Programming" });
            categoryModel.append({ name: "Segment Tree",         selected: false, enabled: true,  type: "Programming" });
            categoryModel.append({ name: "Sliding Window",       selected: false, enabled: true,  type: "Programming" });
            categoryModel.append({ name: "Sorting",              selected: false, enabled: false, type: "Programming" });
            categoryModel.append({ name: "String",               selected: false, enabled: true,  type: "Programming" });
            categoryModel.append({ name: "Topo. Sort",           selected: false, enabled: true,  type: "Programming" });
            categoryModel.append({ name: "Tree",                 selected: false, enabled: false, type: "Programming" });
            categoryModel.append({ name: "Trie",                 selected: false, enabled: true,  type: "Programming" });
            categoryModel.append({ name: "Two Pointers",         selected: false, enabled: false, type: "Programming" });
            categoryModel.append({ name: "Union-Find",           selected: false, enabled: false, type: "Programming" });
            categoryModel.append({ name: "Matrix",               selected: false, enabled: false, type: "Programming" });
            categoryModel.append({ name: "Database",             selected: false, enabled: false, type: "Programming" });
            categoryModel.append({ name: "Shell",                selected: false, enabled: false, type: "Programming" });
        }

        function updateSystemDesignModel() {
            categoryModel.clear();

            categoryModel.append({ name: "Load balancer", selected: false, enabled: true, type: "System Design" });
            categoryModel.append({ name: "Cache",         selected: false, enabled: true, type: "System Design" });
        }

        function updateSelectedCategories() {
            for (let categoryType in sessionObject.selectedCategories) {
                let categories = sessionObject.selectedCategories[categoryType];
                for (let i = 0; i < categories.length; i++) {
                    let category = categories[i];
                    for (let j = 0; j < categoryModel.count; j++) {
                        if (categoryModel.get(j).name === category) {
                            categoryModel.setProperty(j, "selected", categoryModel.get(j).enabled);
                            isCategorySelected = true;
                        }
                    }
                }
            }
        }

        function updateTopic(currentTopic) {
            switch (currentTopic) {
                case "Programming":
                    d.updateComputerScienceModel();
                    break;
                case "System Design":
                    d.updateSystemDesignModel();
                    break;
            }

            sessionObject.topic = currentTopic
            sessionObject.saveSession();
            d.updateSelectedCategories(currentTopic);
        }
    }

    ScrollView {
        width: parent.width - 300
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 10
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
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    text: "Select a topic"
                    font.pixelSize: 24
                    anchors.centerIn: parent
                    color: themeObject.textColor
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -15
                }
            }

            Text {
                anchors.top: title.bottom
                anchors.topMargin: 10
                text: "Each topic contains a set of sub-topics, containing questions to solve."
                font.pixelSize: 14
                font.bold: sessionObject.isFontBold
                color: themeObject.textColor
                anchors.horizontalCenter: parent.horizontalCenter
            }

            ComboBox {
                id: topicComboBox
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -15

                model: ["Programming", "System Design"]

                currentIndex: {
                    // Default to 0 if the session object has no valid topic
                    var value = 0;
                    if (sessionObject.topic === "Programming") {
                        value = 0;
                    } else if (sessionObject.topic === "System Design") { // Corrected condition
                        value = 1;
                    }
                    currentTopic = sessionObject.topic; // Sync currentTopic with the session object
                    return value;
                }

                Component.onCompleted: {
                    // Set the currentIndex and update the model based on the session topic
                    if (sessionObject.topic === "Programming") {
                        topicComboBox.currentIndex = 0;
                        d.updateComputerScienceModel();
                    } else if (sessionObject.topic === "System Design") {
                        topicComboBox.currentIndex = 1;
                        d.updateSystemDesignModel();
                    } else {
                        topicComboBox.currentIndex = 0; // Fallback default
                    }
                    currentTopic = sessionObject.topic;
                    d.updateSelectedCategories(); // Update selected categories after setting the topic
                }

                MouseArea {
                    id: comboBoxMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    acceptedButtons: Qt.NoButton
                }

                background: Rectangle {
                    radius: 10
                    color: comboBoxMouseArea.containsMouse ? themeObject.buttonHoveredColor : themeObject.buttonColor
                    border.color: themeObject.buttonBorderColor
                    border.width: 1
                }

                contentItem: Text {
                    text: topicComboBox.currentText
                    font.bold: sessionObject.isFontBold
                    elide: Text.ElideRight
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.fill: parent
                    anchors.margins: 10
                    color: themeObject.textColor
                }

                onActivated: {
                    currentTopic = topicComboBox.currentText;
                    sessionObject.topic = currentTopic;
                    sessionObject.saveSession();
                    d.updateTopic(currentTopic);
                }

                popup: Popup{
                    y: topicComboBox.height + 2
                    x: topicComboBox.x - 2.65 * topicComboBox.width
                    width: topicComboBox.implicitWidth * 1.26
                    implicitHeight: contentItem.implicitHeight > 250 ? 250 : contentItem.implicitHeight
                    padding: 4
                    contentItem: ListView {
                        implicitHeight: contentHeight
                        keyNavigationEnabled: true
                        model:topicComboBox.popup.visible ? topicComboBox.delegateModel : null
                        clip: true
                        focus: true
                        currentIndex: topicComboBox.highlightedIndex
                    }

                    background: Rectangle {
                        anchors.fill: parent
                        radius: 6
                        border.width: 0.6
                        border.color: themeObject.buttonBorderColor
                        clip: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }

            Flow {
                id: categoriesFlow
                width: parent.width
                spacing: 5
                anchors.horizontalCenterOffset: 15

                Repeater {
                    model: categoryModel
                    anchors.horizontalCenter: parent.horizontalCenter

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
                            font.family: "Noto Color Emoji"
                            text: model.enabled ? model.name : "🔒"
                            font.pixelSize: 14
                            font.bold: sessionObject.isFontBold
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

                                let categoryType = model.type;
                                if (!sessionObject.selectedCategories[categoryType]) {
                                    sessionObject.selectedCategories[categoryType] = [];
                                }

                                if (model.selected) {
                                    if (!sessionObject.selectedCategories[categoryType].includes(model.name)) {
                                        sessionObject.selectedCategories[categoryType].push(model.name);
                                    }
                                    isCategorySelected = true;
                                } else {
                                    const index = sessionObject.selectedCategories[categoryType].indexOf(model.name);
                                    if (index > -1) {
                                        sessionObject.selectedCategories[categoryType].splice(index, 1);

                                        if (sessionObject.selectedCategories[categoryType].length === 0) {
                                            delete sessionObject.selectedCategories[categoryType];
                                        }
                                    }
                                }

                                sessionObject.saveSession();
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
                font.bold: sessionObject.isFontBold
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
