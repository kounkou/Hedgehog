#include "includes/documenthandler.h"

#include <QFile>
#include <QFileDialog>
#include <QOperatingSystemVersion>
#include <QQmlEngine>
#include <QSettings>
#include <QTextStream>
#include <QUrl>

#include "includes/highlighter.h"

DocumentHandler::DocumentHandler(QObject* parent)
    : QObject(parent) {
}

bool DocumentHandler::isDarkMode() {
    if (QOperatingSystemVersion::currentType() != QOperatingSystemVersion::MacOS) {
        return false;
    }

    QSettings settings("Apple", "General");
    QString theme = settings.value("AppleInterfaceStyle", "").toString();
    return theme == "Dark";
}

void DocumentHandler::openFile(const QString& path) {
    QUrl url(path);
    QFile file(url.toLocalFile());
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return;
    QTextStream stream(&file);
    auto text = stream.readAll();
    setText(text);
    file.close();
}

void DocumentHandler::setDocument(QQuickTextDocument* document, const QString& theme) {
    auto highlighter = new Highlighter(document->textDocument(), theme);
    Q_UNUSED(highlighter)
}

QString DocumentHandler::text() const {
    return m_text;
}

void DocumentHandler::setText(QString text) {
    if (m_text != text) {
        m_text = text;
        emit textChanged(text);
    }
}

bool DocumentHandler::saveToFile(const QString& filename, const QString& content) {
    QFile file(filename);

    if (!file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        qWarning() << "Could not open file for writing:" << filename;
        return false;
    }

    QTextStream out(&file);
    out << content;
    file.close();
    return true;
}

QString DocumentHandler::loadFromFile(const QString& filename) {
    QFile file(filename);

    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "Could not open file for reading:" << filename;
        return QString();
    }

    QTextStream in(&file);
    QString content = in.readAll();
    file.close();
    return content;
}