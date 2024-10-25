import QtQuick 2.15

QtObject {
    id: sessionObject

    property var selectedCategories: []
    property string theme: "white"

    function saveSession() {
        var sessionData = {
            selectedCategories: selectedCategories,
            theme: themeObject.theme
        };
        var content = JSON.stringify(sessionData);
        var filePath = "sessionData.json";
        documentHandler.saveToFile(filePath, content);
    }

    function loadSession() {
        var filePath = "sessionData.json";
        var content = documentHandler.loadFromFile(filePath);
        if (content) {
            try {
                var data = JSON.parse(content);
                selectedCategories = data.selectedCategories || [];
                theme = data.theme || theme;
                themeObject.theme = theme
            } catch (e) {
                console.error("Failed to parse session data: " + e);
            }
        }
    }

    Component.onCompleted: {
        loadSession();
    }
}
