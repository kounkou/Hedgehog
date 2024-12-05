#include <QCoreApplication>
#include <QQmlApplicationEngine>
#include <QtTest>

class QmlTests : public QObject {
    Q_OBJECT

   private slots:
    void initTestCase();
    void cleanupTestCase();

    void testInit();
    void testWelcomePage();

   private:
    QQmlApplicationEngine engine;
};
