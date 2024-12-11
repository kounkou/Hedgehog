#include "includes/highlighter.h"

Highlighter::Highlighter(QTextDocument *parent, const QString &theme)
    : QSyntaxHighlighter(parent) {
    HighlightingRule rule;

    if (theme == "dark") {
        keywordFormat.setForeground(QColorConstants::Svg::lightblue);
    } else {
        keywordFormat.setForeground(Qt::darkBlue);
    }
    keywordFormat.setFontWeight(QFont::Bold);
    QStringList keywordPatterns;
    keywordPatterns << "\\balignas\\b" << "\\balignof\\b" << "\\band\\b" << "\\band_eq\\b"
                    << "\\basm\\b" << "\\bauto\\b" << "\\bbreak\\b" << "\\bcase\\b"
                    << "\\bcatch\\b" << "\\bchar\\b" << "\\bchar16_t\\b" << "\\bchar32_t\\b"
                    << "\\bclass\\b" << "\\bcompl\\b" << "\\bconcept\\b" << "\\bconst\\b"
                    << "\\bconst_cast\\b" << "\\bconstexpr\\b" << "\\bcontinue\\b"
                    << "\\bco_await\\b" << "\\bco_return\\b" << "\\bco_yield\\b"
                    << "\\bdecltype\\b" << "\\bdefault\\b" << "\\bdelete\\b" << "\\bdo\\b"
                    << "\\bdouble\\b" << "\\bdynamic_cast\\b" << "\\belse\\b" << "\\benum\\b"
                    << "\\bexplicit\\b" << "\\bexport\\b" << "\\bextern\\b" << "\\bfalse\\b"
                    << "\\bfinal\\b" << "\\bfloat\\b" << "\\bfor\\b" << "\\bfriend\\b"
                    << "\\bgoto\\b" << "\\bif\\b" << "\\binline\\b" << "\\bint\\b" << "\\bbool\\b"
                    << "\\blong\\b" << "\\bmutable\\b" << "\\bnamespace\\b" << "\\bnew\\b"
                    << "\\bnoexcept\\b" << "\\bnot\\b" << "\\bnot_eq\\b" << "\\bnullptr\\b"
                    << "\\boperator\\b" << "\\bor\\b" << "\\bor_eq\\b" << "\\boverride\\b"
                    << "\\bprivate\\b" << "\\bprotected\\b" << "\\bpublic\\b" << "\\bregister\\b"
                    << "\\breinterpret_cast\\b" << "\\breturn\\b" << "\\bshort\\b" << "\\bsigned\\b"
                    << "\\bsizeof\\b" << "\\bstatic\\b" << "\\bstatic_assert\\b" << "\\bstatic_cast\\b"
                    << "\\bstruct\\b" << "\\bswitch\\b" << "\\btemplate\\b" << "\\bthis\\b"
                    << "\\bthread_local\\b" << "\\bthrow\\b" << "\\btrue\\b" << "\\btry\\b"
                    << "\\btypedef\\b" << "\\btypeid\\b" << "\\btypename\\b" << "\\bunion\\b"
                    << "\\bunsigned\\b" << "\\busing\\b" << "\\bvirtual\\b" << "\\bvoid\\b"
                    << "\\bvolatile\\b" << "\\bwchar_t\\b" << "\\bwhile\\b" << "\\bxor\\b"
                    << "\\bxor_eq\\b" << "\\binclude\\b" << "\\bmake_unique\\b"
                    << "\\bstd::\\b" << "\\bstring\\b" << "\\bvector\\b" << "\\bcout\\b";

    foreach (const QString &pattern, keywordPatterns) {
        rule.pattern = QRegExp(pattern);
        rule.format = keywordFormat;
        highlightingRules.append(rule);
    }

    if (theme == "dark") {
        classFormat.setFontWeight(QFont::Bold);
        classFormat.setForeground(Qt::magenta);  // Brighter for dark theme
        highlightingRules.append({QRegExp("\\bQ[A-Za-z]+\\b"), classFormat});

        singleLineCommentFormat.setForeground(Qt::lightGray);  // Brighter for dark
        highlightingRules.append({QRegExp("//[^\n]*"), singleLineCommentFormat});

        multiLineCommentFormat.setForeground(Qt::lightGray);  // Brighter for dark

        quotationFormat.setForeground(Qt::green);  // Brighter for dark theme
        highlightingRules.append({QRegExp("\".*\""), quotationFormat});

        functionFormat.setFontItalic(false);
        functionFormat.setForeground(QColorConstants::Svg::darkorange);  // Stands out on dark background
        highlightingRules.append({QRegExp("\\b[A-Za-z0-9_]+(?=\\()"), functionFormat});
    } else {
        // White theme (light)
        classFormat.setFontWeight(QFont::Bold);
        classFormat.setForeground(Qt::darkMagenta);  // Darker for light theme
        highlightingRules.append({QRegExp("\\bQ[A-Za-z]+\\b"), classFormat});

        singleLineCommentFormat.setForeground(Qt::gray);  // Softer for light
        highlightingRules.append({QRegExp("//[^\n]*"), singleLineCommentFormat});

        multiLineCommentFormat.setForeground(Qt::gray);  // Softer for light

        quotationFormat.setForeground(Qt::darkGreen);  // Softer green for light theme
        highlightingRules.append({QRegExp("\".*\""), quotationFormat});

        functionFormat.setFontItalic(false);
        functionFormat.setForeground(Qt::blue);  // Blue stands out on light
        highlightingRules.append({QRegExp("\\b[A-Za-z0-9_]+(?=\\()"), functionFormat});
    }

    commentStartExpression = QRegExp("/\\*");
    commentEndExpression = QRegExp("\\*/");
}

void Highlighter::highlightBlock(const QString &text) {
    foreach (const HighlightingRule &rule, highlightingRules) {
        QRegExp expression(rule.pattern);
        int index = expression.indexIn(text);
        while (index >= 0) {
            int length = expression.matchedLength();
            setFormat(index, length, rule.format);
            index = expression.indexIn(text, index + length);
        }
    }

    setCurrentBlockState(0);

    int startIndex = 0;
    if (previousBlockState() != 1)
        startIndex = commentStartExpression.indexIn(text);

    while (startIndex >= 0) {
        int endIndex = commentEndExpression.indexIn(text, startIndex);
        int commentLength;
        if (endIndex == -1) {
            setCurrentBlockState(1);
            commentLength = text.length() - startIndex;
        } else {
            commentLength = endIndex - startIndex + commentEndExpression.matchedLength();
        }
        setFormat(startIndex, commentLength, multiLineCommentFormat);
        startIndex = commentStartExpression.indexIn(text, startIndex + commentLength);
    }
}
