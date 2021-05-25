#include "chartmodel_c.h"

ChartModel_c* ChartModel_c::mInstance_ptr = nullptr;

ChartModel_c::ChartModel_c(QObject *parent) : QObject(parent)
{
    mLine.append(0, 0);
}

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

const QLineSeries &ChartModel_c::line() const
{
    return mLine;
}

const QStringList &ChartModel_c::names() const
{
    return mNames;
}

void ChartModel_c::update(QAbstractSeries *series)
{
    if (series) {
        QLineSeries *xySeries = static_cast<QLineSeries *>(series);

        QBarCategoryAxis *axisX = new QBarCategoryAxis();
        axisX->append(mNames);
        xySeries->attachAxis(axisX);
        xySeries->replace(mLine.points());
    }
}

void ChartModel_c::updateBar(QBarCategoryAxis *bars)
{
    if (bars) {
        bars->clear();
        bars->append(mNames);
    }
}

void ChartModel_c::addDataToChart(const QString &_lectureName, const int &_testScore)
{
    if(!mNames.contains(_lectureName))
    {
        mChart.insert(_lectureName, _testScore);
        mNames.append(_lectureName);
        mLine.append(mChart.size(), _testScore);
    }
    else {
        int position{0};
        QMapIterator<QString, int> i(mChart);
        while (i.hasNext()) {
            if(i.key() != _lectureName)
            {
                ++position;
                i.next();
            }
            else {
                mChart[_lectureName] = _testScore;
                mLine.append(position, _testScore);
            }
        }
    }
    emit lineChanged();
    emit namesChanged();
}
