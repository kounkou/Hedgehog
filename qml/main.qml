import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: root
    visible: true
    minimumWidth: 930
    maximumWidth: 930
    minimumHeight: 600
    maximumHeight: 650

    color: themeObject.backgroundColor

    property var session: {
        selectedCategories: []
    }

    Theme {
        id: themeObject
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: WelcomePage{
            theme: root.themeObject || "light"
        }
    }

    Component {
        id: welcomePage
        WelcomePage{
            theme: root.themeObject
        }
    }

    Component {
        id: sectionPage
        SectionPage{
        }
    }

    Component {
        id: practicePage
        PracticePage{
            session: root.session
        }
    }

    Component {
        id: reviewPage
        ReviewPage{
        }
    }

    Component {
        id: statsPage
        StatsPage{
        }
    }

    Component {
        id: aboutPage
        AboutPage{
        }
    }

    Component { 
        id: categoryPage
        CategoryPage{
            session: root.session
        }
    }
}
