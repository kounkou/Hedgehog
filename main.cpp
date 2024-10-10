#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>
#include <QtWebEngine/QtWebEngine>

int main(int argc, char *argv[]) {
    QtWebEngine::initialize();

    QGuiApplication app(argc, argv);

    app.setWindowIcon(QIcon("qrc:/app_icon.icns"));

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}
