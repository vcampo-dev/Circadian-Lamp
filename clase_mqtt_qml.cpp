#include "clase_mqtt_qml.h"
#include <QDebug>
#include <QMqttTopicName>

clase_mqtt_qml::clase_mqtt_qml(QObject *parent):QObject(parent)
{
    connect(&m_client, &QMqttClient::hostnameChanged, this, &clase_mqtt_qml::hostnameChanged);
    connect(&m_client, &QMqttClient::portChanged, this, &clase_mqtt_qml::portChanged);
    connect(&m_client, &QMqttClient::stateChanged, this, &clase_mqtt_qml::stateChanged);
}

void clase_mqtt_qml::connectToHost()
{
    m_client.connectToHost();
}

void clase_mqtt_qml::disconnectFromHost()
{
    m_client.disconnectFromHost();
}

const QString clase_mqtt_qml::hostname() const
{
    return m_client.hostname();
}

void clase_mqtt_qml::setHostname(const QString &newHostname)
{
    m_client.setHostname(newHostname);
}

int clase_mqtt_qml::port() const
{
    return m_client.port();
}

void clase_mqtt_qml::setPort(int newPort)//Modificado del original
{
    m_client.setPort(static_cast<quint16>(newPort));
}

const QMqttClient::ClientState clase_mqtt_qml::state() const
{
    return m_client.state();
}

void clase_mqtt_qml::setState(const QMqttClient::ClientState &newState)
{
    m_client.setState(newState);
}

int clase_mqtt_qml::publish(const QString &topic, const QString &message, int qos, bool retain)
{
    auto result=m_client.publish(QMqttTopicName(topic), message.toUtf8(), qos, retain);
    return result;
}
