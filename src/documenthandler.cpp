#include "includes/documenthandler.h"

#include <QFile>
#include <QFileDialog>
#include <QQmlEngine>
#include <QTextStream>
#include <QUrl>

#include "includes/highlighter.h"

DocumentHandler::DocumentHandler(QObject* parent)
    : QObject(parent) {
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