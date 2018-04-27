#include "filereader.h"
#include <QFile>

FileReader::FileReader(QObject *parent) : QObject(parent)
{
    #ifdef Q_OS_LINUX
        paths << QDir::homePath();
    #endif
    #ifdef Q_OS_ANDROID
        paths << "file:///sdcard" << "file:///storage/sdcard1";
    #endif
}

void FileReader::invokeMainReadMethod()
{
    foreach(auto itm, paths)
        readFromAllFolder(itm);

    emit readingFinished();
}

void FileReader::readFromAllFolder(QString path)
{
    QDir dir(path);
    QFileInfoList tmplist;
    tmplist = dir.entryInfoList(filter, QDir::AllDirs | QDir::Files);
    foreach(QFileInfo itm, tmplist)
    {
        if(itm.isFile())
        {
            emit addToModel(itm.filePath());
        }
        if(itm.isDir())
        {
            QString pth = itm.fileName();
            if( (pth != "." && pth != "..") )
            {
                //qDebug()<<pth;
                readFromAllFolder(itm.filePath()); // recursive function call
            }
        }
    }
    return ;
}

FileReader::~FileReader()
{
    qDebug()<<"file reader destructor";
}
