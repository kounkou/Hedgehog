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

    CustomTimer {
        id: customTimerObject
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: welcomeLoader.sourceComponent
    }

    Loader {
        id: welcomeLoader
        sourceComponent: WelcomePage {
            theme: root.themeObject || "light"
        }
    }

    Loader {
        id: loginLoader
        sourceComponent: LoginPage {}
    }

    Loader {
        id: sectionLoader
        sourceComponent: SectionPage {}
    }

    Loader {
        id: practiceLoader
        sourceComponent: PracticePage {
            session: sessionObject.session
        }
    }

    Loader {
        id: reviewLoader
        sourceComponent: ReviewPage {}
    }

    Loader {
        id: statsLoader
        sourceComponent: StatsPage {}
    }

    Loader {
        id: aboutLoader
        sourceComponent: AboutPage {}
    }

    Loader {
        id: categoryLoader
        sourceComponent: CategoryPage {}
    }

    Loader {
        id: settingsLoader
        sourceComponent: SettingsPage {}
    }
}
