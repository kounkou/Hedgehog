import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: root
    visible: true
    minimumWidth: 950
    maximumWidth: 950
    minimumHeight: 600
    maximumHeight: 600

    color: themeObject.backgroundColor

    Session {
        id: sessionObject
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
            session: sessionObject.session
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
        }
    }
}
