#include "lecturecontroller_c.h"

#include "networkmodel_c.h"
#include "jsonconverter.h"
#include "notificationmodel_c.h"
#include "courselistmodel_c.h"
#include "recommendationlistmodel_c.h"
#include "searchhightlight.h"

#include <QTextCharFormat>

LectureController_c::LectureController_c(QObject *parent) : QObject(parent), mDocument_ptr(nullptr)
{
    connect(NotificationModel_c::instance(), &NotificationModel_c::lectureRecieved, this, &LectureController_c::onLectureRecieved);
    connect(CourseListModel_c::instance(), &CourseListModel_c::lectureRecived, this, &LectureController_c::onLectureRecieved);
}

void LectureController_c::sendLecture(QQuickTextDocument *_lecture, const QString &_lectureName, const QString &_courseName)
{
    QJsonObject lectureJson = JsonConverter::fromLectureToJson(_lecture->textDocument()->toHtml(), _lectureName, _courseName);
    if(NetworkModel_c::instance()->sendJson(lectureJson))
    {
        qDebug() << "lecture send";
        RecommendationListModel_c::instance()->clearRecommendations();
    }
    else
    {
        qDebug() << "lecture not send";
    }
}

void LectureController_c::onLectureRecieved(const QString &_lecture)
{
    if (mDocument_ptr)
    {
        mDocument_ptr->textDocument()->setHtml(_lecture);
        emit lectureRecieved();
    }
}

QQuickTextDocument *LectureController_c::document()
{
    return mDocument_ptr;
}

void LectureController_c::setDocument(QQuickTextDocument *_doc)
{
    if (!_doc || (mDocument_ptr == _doc))
        return;
    if (mDocument_ptr)
        mDocument_ptr->textDocument()->disconnect(this);
    mDocument_ptr = _doc;

//    m_searchHighLight = new SearchHighLight(mDocument_ptr->textDocument());
}

void LectureController_c::selectText(const QString &_linkToText)
{
    m_searchHighLight->searchText(_linkToText);
    //    bool found{false};

    //    QTextCursor highlightCursor(mDocument_ptr->textDocument()->find(_linkToText, highlightCursor, QTextDocument::FindWholeWords));
    //    QTextCursor cursor(mDocument_ptr->textDocument().);

    //    cursor.beginEditBlock();
    //    QTextCharFormat plainFormat(highlightCursor.charFormat());
    //    QTextCharFormat colorFormat = plainFormat;
    //    colorFormat.setForeground(Qt::yellow);

    //    while (!highlightCursor.isNull() && !highlightCursor.atEnd()) {
    //        highlightCursor = mDocument_ptr->textDocument()->find(_linkToText, highlightCursor, QTextDocument::FindWholeWords);

    //        if (!highlightCursor.isNull()) {
    //            found = true;
    //            highlightCursor.movePosition(QTextCursor::WordRight, QTextCursor::KeepAnchor);
    //            highlightCursor.mergeCharFormat(colorFormat);
    //        }
    //    }
    //    cursor.endEditBlock();
}
