#include "searchhightlight.h"

#include <QTextCharFormat>

SearchHighLight::SearchHighLight(QTextDocument* parent) : BaseClass(parent)
{
    // Set the backlight color
    m_format.setBackground(Qt::green);
}

void SearchHighLight::highlightBlock(const QString& text)
{
    // Using a regular expression, we find all matches.
    QRegularExpressionMatchIterator matchIterator = m_pattern.globalMatch(text);
    while (matchIterator.hasNext())
    {
        // Highlight all matches
        QRegularExpressionMatch match = matchIterator.next();
        setFormat(match.capturedStart(), match.capturedLength(), m_format);
    }
}

void SearchHighLight::searchText(const QString& text)
{
}
