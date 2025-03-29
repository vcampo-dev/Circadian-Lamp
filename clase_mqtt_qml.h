#ifndef CLASE_MQTT_QML_H
#define CLASE_MQTT_QML_H

#include <QtCore/QMap>
#include <QtMqtt/QMqttClient>
#include <QtMqtt/QMqttSubscription>

#include <QtQml/qqml.h>

class clase_mqtt_qml : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString hostname READ hostname WRITE setHostname NOTIFY hostnameChanged)
    Q_PROPERTY(int port READ port WRITE setPort NOTIFY portChanged)
    Q_PROPERTY(QMqttClient::ClientState state READ state WRITE setState NOTIFY stateChanged)
    QML_NAMED_ELEMENT(MqttClient)
    QML_EXTENDED_NAMESPACE(QMqttClient)
public:
    clase_mqtt_qml(QObject *parent=nullptr);

    Q_INVOKABLE void connectToHost();
    Q_INVOKABLE void disconnectFromHost();
    Q_INVOKABLE int publish(const QString &topic, const QString &message, int qos=0, bool retain=false);

    const QString hostname() const;
    void setHostname(const QString &newHostname);

    int port() const;
    void setPort(int newPort);

    const QMqttClient::ClientState state() const;
    void setState(const QMqttClient::ClientState &newState);

signals:
    void hostnameChanged();
    void portChanged();
    void stateChanged();

private:
    Q_DISABLE_COPY(clase_mqtt_qml)
    QMqttClient m_client;
};

#endif // CLASE_MQTT_QML_H
