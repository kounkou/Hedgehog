import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: timerObject

    property alias appearanceMonitoringTimer: appearanceMonitoringTimer

    Timer {
        id: appearanceMonitoringTimer

        interval: 5000
        running: true
        repeat: true
        triggeredOnStart: true

        onTriggered: {
            sessionObject.loadSession()
        }
    }

    function startTimer() {
        appearanceMonitoringTimer.start();
    }

    function stopTimer() {
        appearanceMonitoringTimer.stop();
    }
}