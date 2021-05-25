#include "chartmodel_c.h"

ChartModel_c* ChartModel_c::mInstance_ptr = nullptr;

ChartModel_c::ChartModel_c(QObject *parent) : QObject(parent)
{}

QObject *ChartModel_c::qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);
    return ChartModel_c::instance();
}

ChartModel_c *ChartModel_c::instance()
{
    if (!mInstance_ptr)
    {
        mInstance_ptr = new ChartModel_c;
    }
    return mInstance_ptr;
}

void ChartModel_c::addDataToChart(const QString &_lectureName, const int &_testScore)
{
    mChart.insert(_lectureName, _testScore);
}
