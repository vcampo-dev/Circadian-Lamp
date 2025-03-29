#include "jsonforqml.h"

JsonForQml::JsonForQml(QObject *parent)
    : QObject{parent}
{}

int JsonForQml::read_json(const QString &identifier)
{
    return j_Obj.value(identifier).toDouble();
}

void JsonForQml::modify_json(const QString &identifier, int data)
{
    j_Obj[identifier]=data;
}

QString JsonForQml::send_json()
{
    return QJsonDocument(j_Obj).toJson(QJsonDocument::Compact) + '\n';
}

void JsonForQml::initialice_json()
{
  QJsonObject initialice
        {
            {"ID", "VCH_TFG_2489"},
            {"ON_OFF", 0},
            {"Mode", 0},
            {"I_White", 0},
            {"I_Yellow", 0}
        };
   j_Obj=initialice;
}
