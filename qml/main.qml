import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: root
    visible: true
<<<<<<< Updated upstream
    minimumWidth: 950
    maximumWidth: 950
    minimumHeight: 600
    maximumHeight: 600
=======
    minimumWidth: 1100
    maximumWidth: 1100
    minimumHeight: 700
    maximumHeight: 700
>>>>>>> Stashed changes

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
