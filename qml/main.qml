import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: root
    visible: true

    minimumWidth: 1100
    maximumWidth: 1100
    minimumHeight: 700
    maximumHeight: 700

    color: themeObject.backgroundColor

    Session {
        id: sessionObject
    }

    Theme {
        id: themeObject
    }

    StackView {
        id: stackView
        objectName: "stackView"
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
            objectName: "loginPage"
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

    Component {
        id: settingsPage
        SettingsPage{
        }
    }
}
