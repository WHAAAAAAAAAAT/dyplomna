#include "commondata.h"

User Network::jsonToUser(const QJsonObject &_json)
{
    return {_json.value(jsonKeys::username).toString(), _json.value(jsonKeys::password).toString(),
            _json.value(jsonKeys::name).toString(), _json.value(jsonKeys::surname).toString()};
}
