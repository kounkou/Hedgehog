import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: root
    visible: true
    minimumWidth: 1100
    // maximumWidth: 950
    minimumHeight: 900
    // maximumHeight: 600

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
        // initialItem: LoginPage{
        // }
        initialItem: WelcomePage{
            theme: root.themeObject || "light"
        }
    }

    Component {
        id: login
        LoginPage{
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
