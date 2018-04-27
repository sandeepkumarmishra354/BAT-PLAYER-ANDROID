#ifndef FILEREADER_H
#define FILEREADER_H

#include <QObject>
#include <QString>
#include <QDebug>
#include <QDir>
#include <QStringList>
#include <QFileInfoList>

class FileReader : public QObject
{
    Q_OBJECT
private:
    QStringList filter = QStringList()<<"*.mp3"<<"*.wav"<<"*.3gpp"<<"*.mp4a";
    QStringList paths;
    QFileInfoList allFileInfo;
public:
    explicit FileReader(QObject *parent = nullptr);
    ~FileReader();
    Q_INVOKABLE void readFromAllFolder(QString path);
signals:
    void addToModel(QString path);
    void readingFinished();

public slots:
    Q_INVOKABLE void invokeMainReadMethod();
};

#endif // FILEREADER_H
