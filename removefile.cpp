#include <QUrl>
#include "removefile.h"

RemoveFile::RemoveFile(QObject *parent) : QObject(parent)
{
    // 1 argument constructor
}
bool RemoveFile::deleteFile(QString file)
{
    QUrl filePath(file);
    QFile fileToDelete(filePath.toLocalFile());
    if(fileToDelete.exists())
    {
        return fileToDelete.remove();
    }
}
