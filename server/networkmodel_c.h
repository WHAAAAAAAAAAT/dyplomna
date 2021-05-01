#pragma once

#include <QObject>
#include <QList>
#include <QByteArray>
#include <QSslError>
#include <QWebSocket>
#include <QWebSocketServer>
#include <QJsonObject>

#include "commondata.h"

class NetworkModel_c : public QObject
{
    Q_OBJECT
public:
    explicit NetworkModel_c(QObject *parent = nullptr);
    static NetworkModel_c* instance();
    ~NetworkModel_c();

    bool sendToAllStudents(const QJsonObject &object);
    bool sendToAllStudents(const QString &text);

private slots:
    void onNewConnection();
    void processTextMessage(QString message);
    void processBinaryMessage(QByteArray _message);
    void socketDisconnected();
    void onSslErrors(const QList<QSslError> &errors);

private:
    QJsonObject convertToJson(const QByteArray &data);
    void parseReceivedJson(const QJsonObject &_obj);
    void parseReceivedText(const QString &_text);

private:
    QMap<QWebSocket *, User> m_teachers;
    QMap<QWebSocket *, Student> m_students;

    QVector<QWebSocket *> m_clients;

    QWebSocketServer *m_pWebSocketServer;
    static NetworkModel_c* mInstance_ptr;
};
