#ifndef JSONFORQML_H
#define JSONFORQML_H

#include <QObject>
#include <QtQml/qqml.h>
#include <QtCore>
#include <QtGui>
#include <QDebug>

class JsonForQml : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit JsonForQml(QObject *parent = nullptr);

    Q_INVOKABLE int read_json(const QString &identifier);
    Q_INVOKABLE void modify_json(const QString &identifier, int data);
    Q_INVOKABLE QString send_json();
    Q_INVOKABLE void initialice_json();

signals:

private:
    Q_DISABLE_COPY(JsonForQml)
    QJsonObject j_Obj
    {
        {"ID", "VCH_TFG_2489"},
        {"ON_OFF", 0},
        {"Mode", 0},
        {"I_White", 0},
        {"I_Yellow", 0}
    };
};

#endif // JSONFORQML_H
