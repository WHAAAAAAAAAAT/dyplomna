#pragma once

#include <QObject>
#include <QMap>
#include <QQmlEngine>
#include <QJSEngine>

class ChartModel_c : public QObject
{
   Q_OBJECT
public:
    explicit ChartModel_c(QObject *parent = nullptr);
    void addDataToChart(const QString &_lectureName, const int &_testScore);
    static QObject *qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine);
    static ChartModel_c* instance();

private:
    QMap<QString, int> mChart;
    static ChartModel_c* mInstance_ptr;
};

