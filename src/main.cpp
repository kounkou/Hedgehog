#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>
// #include <QtWebEngine/QtWebEngine>

#include <QQmlContext>

#include "includes/documenthandler.h"
#include "includes/highlighter.h"

int main(int argc, char *argv[]) {
    // QtWebEngine::initialize();

    QGuiApplication app(argc, argv);

    DocumentHandler document;
    qmlRegisterType<Highlighter>("Hedgehog", 1, 0, "Highlighter");
    app.setWindowIcon(QIcon("qrc:/app_icon.icns"));
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("documentHandler", &document);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}
