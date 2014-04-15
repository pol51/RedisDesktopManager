#pragma once

#include <QtCore>
#include <QtXml>

#define DEFAULT_REDIS_PORT 6379
#define DEFAULT_SSH_PORT 22
#define DEFAULT_TIMEOUT_IN_MS 60000

class RedisConnectionConfig
{
public:
    static const char DEFAULT_NAMESPACE_SEPARATOR = ':';

    // redis connection parameters
    QString name;
    QString host;
    QString auth;
    int port;

    // ssh tunnel connection parameters
    QString sshHost;
    int sshPort = DEFAULT_SSH_PORT;
    QString sshUser;
    QString sshPassword;
    QString sshPublicKey;
    QString sshPrivateKey;

    //timeouts 
    int connectionTimeout = DEFAULT_TIMEOUT_IN_MS;
    int executeTimeout    = DEFAULT_TIMEOUT_IN_MS;

    // other settings
    QString namespaceSeparator;

    RedisConnectionConfig(const QString & host = "", const QString & name = "", const int port = DEFAULT_REDIS_PORT) 
        : name(name), host(host), port(port),
          namespaceSeparator(DEFAULT_NAMESPACE_SEPARATOR)
    {}

    RedisConnectionConfig & operator = (RedisConnectionConfig & other) 
    {
        if (this != &other) {
            name = other.name;
            host = other.host;
            auth = other.auth;
            port = other.port;
            namespaceSeparator = other.namespaceSeparator;
            connectionTimeout = other.connectionTimeout;
            executeTimeout = other.executeTimeout;

            setSshTunnelSettings(
                other.sshHost, other.sshUser, other.sshPassword, other.sshPort,
                other.sshPublicKey, other.sshPublicKey
                );
        }

        return *this;
    }

    void setSshTunnelSettings(QString host, QString user, QString pass, int port = DEFAULT_SSH_PORT, 
	                            QString sshPublicKey = "", QString sshPrivatekey = "");
    
    bool isNull();
    bool useSshTunnel() const;
    bool useAuth() const;
    
    QDomElement toXml(QDomDocument dom);  
       
    static RedisConnectionConfig createFromXml(QDomNode & connectionNode);    

protected:
    void saveXmlAttribute(QDomDocument & document, QDomElement & root, const QString& name, const QString& value);

    static bool getValueFromXml(const QDomNamedNodeMap & attr, const QString& name, QString & value);
    static bool getValueFromXml(const QDomNamedNodeMap & attr, const QString& name, int & value);
};

