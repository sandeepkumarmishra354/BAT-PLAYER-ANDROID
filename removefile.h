#ifndef REMOVEFILE_H
#define REMOVEFILE_H

#include <QObject>
#include <QFile>
#include <QString>
#include <QDebug>

class RemoveFile : public QObject
{
    Q_OBJECT
public:
    explicit RemoveFile(QObject *parent = nullptr);
    Q_INVOKABLE bool deleteFile(QString file);
};

#endif // REMOVEFILE_H
