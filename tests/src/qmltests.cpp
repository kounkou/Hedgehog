#include "includes/qmltests.h"

#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickItem>
#include <QQuickView>
#include <QtWebEngine/QtWebEngine>

#include "includes/documenthandler.h"
#include "includes/highlighter.h"

void QmlTests::initTestCase() {
}

void QmlTests::testInit() {
    DocumentHandler document;
    qmlRegisterType<Highlighter>("Hedgehog", 1, 0, "Highlighter");
    engine.rootContext()->setContextProperty("documentHandler", &document);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    QVERIFY(!engine.rootObjects().isEmpty());
}

void QmlTests::testWelcomePage() {
    QObject *rootObject = engine.rootObjects().first();

    QQuickItem *stackView = rootObject->findChild<QQuickItem *>("stackView");
    QVERIFY(stackView);

    QObject *initialItem = stackView->property("currentItem").value<QObject *>();
    QVERIFY(initialItem);

    QString className = QString::fromUtf8(initialItem->metaObject()->className());
    QVERIFY(className.startsWith("WelcomePage"));
}

void QmlTests::cleanupTestCase() {
}

int main(int argc, char **argv) {
    QtWebEngine::initialize();
    QApplication app(argc, argv);

    QmlTests test;

    return QTest::qExec(&test, argc, argv);
}
