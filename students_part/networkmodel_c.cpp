#include "networkmodel_c.h"

#include <QDebug>
#include <QJsonDocument>

#include "jsontypes.h"
#include "commondata.h"
#include "networkmessages.h"

#include "notificationmodel_c.h"

#include "courselistmodel_c.h"

NetworkModel_c* NetworkModel_c::mInstance_ptr = nullptr;

NetworkModel_c::NetworkModel_c(QObject *parent) :
    QObject(parent)
{
    mUrl = (Network::mIp + ":" + QString::number(Network::port));
    connect(&mWebSocket, &QWebSocket::connected, this, &NetworkModel_c::onConnected);
    connect(&mWebSocket, QOverload<const QList<QSslError>&>::of(&QWebSocket::sslErrors), this, &NetworkModel_c::onSslErrors);
    mWebSocket.open(mUrl);

    connect(this, &NetworkModel_c::textReceived, this, &NetworkModel_c::parseReceivedText);
    connect(this, &NetworkModel_c::jsonReceived, this, &NetworkModel_c::parseReceivedJson);
}

NetworkModel_c *NetworkModel_c::instance()
{
    if (!mInstance_ptr)
    {
        mInstance_ptr = new NetworkModel_c;
    }
    return mInstance_ptr;
}

void NetworkModel_c::onConnected()
{
    qDebug() << "WebSocket connected";
    connect(&mWebSocket, &QWebSocket::textMessageReceived, this, &NetworkModel_c::onTextMessageReceived);
    connect(&mWebSocket, &QWebSocket::binaryMessageReceived, this, &NetworkModel_c::onJsonObjectsReceived);
}

void NetworkModel_c::onTextMessageReceived(const QString &message)
{
    if (!message.isEmpty())
    {
        qDebug() << "Message received: " << message;
        mReceivedTexts.append(message);
        emit textReceived(message);
    }
}

void NetworkModel_c::onJsonObjectsReceived(const QByteArray &data)
{
    if (!data.isEmpty())
    {
        auto json = convertToJson(data);
        if (!json.isEmpty())
        {
            qDebug() << "Json received: " << json;
            mReceivedJsonObjects.append(json);
            emit jsonReceived(json);
        }
    }
}

void NetworkModel_c::onSslErrors(const QList<QSslError> &errors)
{
    qDebug() << errors;
    mWebSocket.ignoreSslErrors();
}

bool NetworkModel_c::sendJson(const QJsonObject &object)
{
    bool result{false};
    if (object.isEmpty())
    {
        qDebug() << "Empty json";
    } else
    {
        QJsonDocument doc(object);
        QByteArray data = doc.toJson();
        result = mWebSocket.sendBinaryMessage(data) > 0;
    }
    return result;
}

bool NetworkModel_c::sendText(const QString &text)
{
    if (!text.isEmpty())
    {
        qDebug() << "Message to send:" << text;
        return mWebSocket.sendTextMessage(text) > 0;
    }
    return false;
}

QJsonObject NetworkModel_c::convertToJson(const QByteArray &data)
{
    return QJsonDocument::fromJson(data).object();
}

void NetworkModel_c::parseReceivedJson(const QJsonObject &_obj)
{
    auto title = _obj.value(jsonKeys::title);
    if (title == jsonValues::lecture)
    {
        Lecture lec = Network::jsonToLecture(_obj);
        CourseListModel_c::instance()->addLecture(lec.name, lec.courseName);
    }
}

void NetworkModel_c::parseReceivedText(const QString &_text)
{
    if (_text == message::loginSuccess)
    {
        emit NotificationModel_c::instance()->loginSuccess();
    } else if (_text == message::loginFail)
    {
        emit NotificationModel_c::instance()->loginFail();
    } else if (_text == message::registrationSuccess)
    {
        emit NotificationModel_c::instance()->registrationSuccess();
    } else if (_text == message::registrationFail)
    {
        emit NotificationModel_c::instance()->registrationFail();
    } else if (_text.startsWith(QStringLiteral("<!DOCTYPE")))
    {
        emit NotificationModel_c::instance()->lectureRecieved(_text);
    }
}
