#include "networkmodel_c.h"

#include <QDebug>
#include <QFile>
#include <QSslCertificate>
#include <QSslKey>
#include <QJsonDocument>

#include "commondata.h"
#include "jsontypes.h"
#include "networkmessages.h"
#include "loginverificationmodel_c.h"

#include "verificationmodel_c.h"
#include "lecturefilemodel_c.h"
#include "coursefoldermodel.h"
#include "testfilemodel_c.h"

QT_USE_NAMESPACE

NetworkModel_c* NetworkModel_c::mInstance_ptr = nullptr;

NetworkModel_c::NetworkModel_c(QObject *parent) :
    QObject(parent),
    m_pWebSocketServer(nullptr)
{
    m_pWebSocketServer = new QWebSocketServer(QStringLiteral("SSL Echo Server"),
                                              QWebSocketServer::SecureMode,
                                              this);
    QSslConfiguration sslConfiguration;
    QFile certFile(QStringLiteral(":/res/localhost.cert"));
    QFile keyFile(QStringLiteral(":/res/localhost.key"));
    certFile.open(QIODevice::ReadOnly);
    keyFile.open(QIODevice::ReadOnly);
    QSslCertificate certificate(&certFile, QSsl::Pem);
    QSslKey sslKey(&keyFile, QSsl::Rsa, QSsl::Pem);
    certFile.close();
    keyFile.close();
    sslConfiguration.setPeerVerifyMode(QSslSocket::VerifyNone);
    sslConfiguration.setLocalCertificate(certificate);
    sslConfiguration.setPrivateKey(sslKey);
    sslConfiguration.setProtocol(QSsl::TlsV1_3);
    m_pWebSocketServer->setSslConfiguration(sslConfiguration);

    if (m_pWebSocketServer->listen(QHostAddress::Any, Network::port))
    {
        qDebug() << "SSL Echo Server2 listening on port" << Network::port;
        connect(m_pWebSocketServer, &QWebSocketServer::newConnection,
                this, &NetworkModel_c::onNewConnection);
        connect(m_pWebSocketServer, &QWebSocketServer::sslErrors,
                this, &NetworkModel_c::onSslErrors);
    }
}

NetworkModel_c *NetworkModel_c::instance()
{
    if (!mInstance_ptr)
    {
        mInstance_ptr = new NetworkModel_c;
    }
    return mInstance_ptr;
}

NetworkModel_c::~NetworkModel_c()
{
    m_pWebSocketServer->close();
}

bool NetworkModel_c::sendToAllStudents(const QJsonObject &object)
{
    bool result{false};
    for (auto client : m_students.keys())
        if (client)
        {
            if (object.isEmpty())
                qDebug() << "Empty json";
            else
            {
                QJsonDocument doc(object);
                QByteArray data = doc.toJson();
                result = client->sendBinaryMessage(data) > 0;
                if (!result)
                    break;
            }
        }
    return result;
}

bool NetworkModel_c::sendToAllTeachers(const QJsonObject &object)
{
    bool result{false};
    for (auto client : m_teachers.keys())
        if (client)
        {
            if (object.isEmpty())
                qDebug() << "Empty json";
            else
            {
                QJsonDocument doc(object);
                QByteArray data = doc.toJson();
                result = client->sendBinaryMessage(data) > 0;
                if (!result)
                    break;
            }
        }
    return result;
}

bool NetworkModel_c::sendToAllStudents(const QString &text)
{
    if (!text.isEmpty())
        qDebug() << "Message to send:" << text;

    bool result{false};

    qDebug() << m_students.keys();
    for (auto client : m_students.keys())
        if (client)
            result = client->sendTextMessage(text) > 0;
    return result;
}

void NetworkModel_c::onNewConnection()
{
    QWebSocket *pSocket = m_pWebSocketServer->nextPendingConnection();

    qDebug() << "Client connected:" << pSocket->peerName() << pSocket->origin();

    connect(pSocket, &QWebSocket::textMessageReceived, this, &NetworkModel_c::processTextMessage);
    connect(pSocket, &QWebSocket::binaryMessageReceived, this, &NetworkModel_c::processBinaryMessage);
    connect(pSocket, &QWebSocket::disconnected, this, &NetworkModel_c::socketDisconnected);

    m_clients.append(pSocket);
}

void NetworkModel_c::processTextMessage(QString message)
{
    QWebSocket *pClient = qobject_cast<QWebSocket *>(sender());
    if (pClient)
    {
        pClient->sendTextMessage(message);
    }
}

void NetworkModel_c::processBinaryMessage(QByteArray _message)
{
    auto _obj = convertToJson(_message);
    auto title = _obj.value(jsonKeys::title);
    QWebSocket *pClient = qobject_cast<QWebSocket *>(sender());

    if (pClient)
    {
        if (title == jsonValues::login_student)
        {
            Student user = Network::jsonToStudent(_obj);
            if (LoginVerificationModel_c::instance()->verifyLoginStudent(user))
            {
                m_students.insert(pClient, user);
                pClient->sendTextMessage(message::loginSuccess);
            } else
            {
                pClient->sendTextMessage(message::loginFail);
            }
        } else if (title == jsonValues::login_teacher)
        {
            User user = Network::jsonToUser(_obj);
            if (LoginVerificationModel_c::instance()->verifyLoginTeacher(user))
            {
                m_teachers.insert(pClient, user);
                pClient->sendTextMessage(message::loginSuccess);
            } else
            {
                pClient->sendTextMessage(message::loginFail);
            }
        } else if (title == jsonValues::registration_student)
        {
            Student user = Network::jsonToStudent(_obj);
            if (LoginVerificationModel_c::instance()->verifyRegistrationStudent(user))
            {
                m_students.insert(pClient, user);
                pClient->sendTextMessage(message::registrationSuccess);
            } else
            {
                pClient->sendTextMessage(message::registrationFail);
            }
        } else if (title == jsonValues::registration_teacher)
        {
            User user = Network::jsonToUser(_obj);
            if (LoginVerificationModel_c::instance()->verifyRegistrationTeacher(user))
            {
                m_teachers.insert(pClient, user);
                pClient->sendTextMessage(message::registrationSuccess);
            } else
            {
                pClient->sendTextMessage(message::registrationFail);
            }
        } else if (title == jsonValues::lecture)
        {
            Lecture lecture = Network::jsonToLecture(_obj);
            LectureFileModel_c::instance()->saveLecture(lecture);
            sendToAllStudents(_obj);
        } else if (title == jsonValues::course)
        {
            CourseItem course = Network::jsonToCourse(_obj);
            CourseFolderModel_c::instance()->saveCourse(course);
            sendToAllStudents(_obj);
        } else if (title == jsonValues::test)
        {
            Test test = Network::jsonToTest(_obj);
            TestFileModel_c::instance()->saveTest(test, _message);
        } else if(title == jsonValues::loadCourses)
        {
            sendToAllTeachers(CourseFolderModel_c::instance()->getCourses());
            sendToAllStudents(CourseFolderModel_c::instance()->getCourses());
        } else if(title == jsonValues::loadLectures)
        {
            sendToAllTeachers(LectureFileModel_c::instance()->getLectures(_obj.value(jsonKeys::courseName).toString()));
            sendToAllStudents(LectureFileModel_c::instance()->getLectures(_obj.value(jsonKeys::courseName).toString()));
        } else if(title == jsonValues::loadTests)
        {
            sendToAllTeachers(TestFileModel_c::instance()->getTest(_obj.value(jsonKeys::courseName).toString(),
                                                                   _obj.value(jsonKeys::lectureName).toString()));
            sendToAllStudents(TestFileModel_c::instance()->getTest(_obj.value(jsonKeys::courseName).toString(),
                                                                   _obj.value(jsonKeys::lectureName).toString()));
        }
    }
}

void NetworkModel_c::socketDisconnected()
{
    qDebug() << "Client disconnected";
    QWebSocket *pClient = qobject_cast<QWebSocket *>(sender());
    if (pClient)
    {
        m_clients.removeAll(pClient);
        m_students.remove(pClient);
        m_teachers.remove(pClient);

        pClient->deleteLater();
    }
}

void NetworkModel_c::onSslErrors(const QList<QSslError> &)
{
    qDebug() << "Ssl errors occurred";
}

QJsonObject NetworkModel_c::convertToJson(const QByteArray &data)
{
    return QJsonDocument::fromJson(data).object();
}

void NetworkModel_c::parseReceivedJson(const QJsonObject &_obj)
{

}
