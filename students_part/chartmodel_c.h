#pragma once

#include <QObject>
#include <QMap>
#include <QQmlEngine>
#include <QJSEngine>
#include <QLineSeries>
#include <QBarCategoryAxis>

using namespace QtCharts;

class ChartModel_c : public QObject
{
   Q_OBJECT
public:

    explicit ChartModel_c(QObject *parent = nullptr);
    void addDataToChart(const QString &_lectureName, const int &_testScore);
    static QObject *qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine);
    static ChartModel_c* instance();

public slots:
    const QLineSeries &line() const;

    const QStringList &names() const;

    void update(QAbstractSeries *series);
    void updateBar(QBarCategoryAxis* bars);

signals:
    void lineChanged();

    void namesChanged();

private:
    QMap<QString, int> mChart;

    QLineSeries mLine;
    QStringList mNames;
    static ChartModel_c* mInstance_ptr;
};


