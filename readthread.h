#ifndef READTHREAD_H
#define READTHREAD_H

#include <QObject>
#include <QThread>
#include <QDebug>
#include <QString>
#include "filereader.h"

class ReadThread : public QObject
{
    Q_OBJECT
private:
    QThread pThread;
    FileReader reader;
public:
    explicit ReadThread(QObject *parent = nullptr);
    ~ReadThread();

signals:
    void addToModel(QString path);
    void readFinished();

public slots:
};

#endif // READTHREAD_H
