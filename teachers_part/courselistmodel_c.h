#pragma once

#include <QObject>
#include <QAbstractListModel>

#include "courseitem.h"
#include "lecture.h"

#include <QQmlEngine>
#include <QJSEngine>
#include <QQuickTextDocument>

class CourseListModel_c : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit CourseListModel_c(QObject *parent = nullptr);

    enum {
        CourseRole,
        LecturesRole,
        VisibleRole,
    };

    int rowCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;

    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    virtual QHash<int, QByteArray> roleNames() const override;

    static QObject *qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine);
    static CourseListModel_c* instance();

public slots:
    void updateVisibleForCourse(const QString &_course);

    void loadLectures(QString _courseName, QString _lectureName);
    void setCourses(QVector<CourseItem> _courses);
    void setLectures(QVector<Lecture> _lectures);
    QStringList lecturesList(int index);
    void addLecture(const QString _lectureName, const QString _courseName);
    void addCourse(const QString &_course);
    void removeCourse(const QString &_course);

    void saveCurrentLecture(QQuickTextDocument *_lecture, const QString &_lectureName, const QString &_courseName);

signals:
    void lectureRecived(QString lectureText);

private:
    QVector<CourseItem> mItems;
    QVector<QVector<Lecture>> mLectures;
    static CourseListModel_c* mInstance_ptr;
};
