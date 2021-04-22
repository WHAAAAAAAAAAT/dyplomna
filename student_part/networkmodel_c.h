#pragma once

#include <QObject>
#include <QWebSocket>
#include <QSslError>
#include <QList>
#include <QString>
#include <QUrl>
#include <QJsonObject>

class NetworkModel_c final : public QObject
{
    Q_OBJECT
public:
    explicit NetworkModel_c(QObject *parent = nullptr);

    static NetworkModel_c* instance();

public slots:
    void onTextMessageReceived(const QString &message);
    void onJsonObjectsReceived(const QByteArray &data);
    bool sendJson(const QJsonObject &object);
    bool sendText(const QString &text);

private slots:
    void onConnected();
    void onSslErrors(const QList<QSslError> &errors);

    void parseReceivedJson(const QJsonObject &_obj);
    void parseReceivedText(const QString &_text);

private:
    QJsonObject convertToJson(const QByteArray &data);

signals:
    void jsonReceived(const QJsonObject &obj);
    void textReceived(const QString &text);

private:
    QVector<QString> mReceivedTexts;
    QVector<QJsonObject> mReceivedJsonObjects;
    QWebSocket mWebSocket;
    QUrl mUrl;
    static NetworkModel_c* mInstance_ptr;
};
