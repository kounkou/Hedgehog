import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "handler.js" as QuestionsHandler

Rectangle {
    id: imageGridPage
    Layout.fillWidth: true
    Layout.fillHeight: true
    color: themeObject.backgroundColor
    property string searchQuery: ""  // To store the search input

    anchors {
        left: parent.left
        right: parent.right
        top: parent.top
        bottom: parent.bottom
        margins: 10
    }

    ListModel {
        id: imageModel

        Component.onCompleted: {
            for (var i = 0; i < QuestionsHandler.getTotalQuestions(); i++) {
                const result = QuestionsHandler.getAnswerDetails(i)
                imageModel.append({ source: result.source, title: result.title })
            }
        }
    }

    ListModel {
        id: filteredModel

        Component.onCompleted: {
            for (var i = 0; i < QuestionsHandler.getTotalQuestions(); i++) {
                const result = QuestionsHandler.getAnswerDetails(i)
                filteredModel.append({ source: result.source, title: result.title })
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent

        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            
            GridLayout {
                columns: 3
                anchors.margins: 10

                Repeater {
                    model: filteredModel
                    delegate: Column {
                        width: 100
                        height: 120

                        Rectangle {
                            width: 300
                            height: 300
                            color: themeObject.backgroundColor

                            Image {
                                source: model.source
                                anchors.fill: parent
                                fillMode: Image.PreserveAspectFit
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    fullScreenImage.source = model.source
                                    fullScreenImage.visible = true
                                }
                            }
                        }
                        
                        Text {
                            text: model.title
                            font.pixelSize: 14
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            width: parent.width
                            color: themeObject.textColor
                        }
                    }
                }
            }
        }

        TextField {
            id: searchBar
            placeholderText: "🦔 Search algorithms..."
            // anchors.top: parent.top
            // anchors.horizontalCenter: parent.horizontalCenter
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            width: 400
            color: themeObject.textColor

            onTextChanged: {
                searchQuery = searchBar.text
                filterModel()
            }

            background: Rectangle {
                radius: 10
                border.width: 1
                border.color: themeObject.buttonColor
                color: themeObject.buttonColor
            }
        }

        Button {
            id: backButton
            text: "Go to home"
            width: 200
            height: 50
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            visible: !fullScreenImage.visible
            onClicked: {
                stackView.pop()
            }

            contentItem: Text {
                text: backButton.text
                font: backButton.font
                opacity: enabled ? 1.0 : 0.3
                color: themeObject.textColor
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                radius: 10
                border.width: 1
                border.color: themeObject.buttonColor
                color: {
                    return backButton.hovered ? themeObject.buttonHoveredColor : themeObject.buttonColor
                }
            }
        }
    }

    Image {
        id: fullScreenImage
        visible: false
        width: parent.width
        height: parent.height
        fillMode: Image.PreserveAspectFit
        anchors.centerIn: parent

        MouseArea {
            anchors.fill: parent
            onClicked: fullScreenImage.visible = false
        }
    }

    // Function to filter the model based on the search query
    function filterModel() {
        filteredModel.clear()  // Clear the filtered model

        for (var i = 0; i < imageModel.count; i++) {
            var title = imageModel.get(i).title.toLowerCase()
            var query = searchQuery.toLowerCase()

            // If the title contains the search query, add it to the filtered model
            if (title.indexOf(query) !== -1) {
                filteredModel.append(imageModel.get(i))
            }
        }
    }

    Component.onCompleted: {
        // Initially populate the filtered model with all the items
        filterModel()
    }
}
