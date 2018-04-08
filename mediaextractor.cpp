#include <QDebug>
#include <QImage>
#include "mediaextractor.h"

MediaExtractor::MediaExtractor(QObject *parent) : QObject(parent)
{
    // constructor
}

void MediaExtractor::mediaMetaData(QString mediaPath)
{
    QUrl mediaURL(mediaPath);
    QString localFile = mediaURL.toLocalFile();
    TagLib::FileRef mediaFile(localFile.toStdString().c_str());
    if(!mediaFile.isNull() && mediaFile.tag())
    {
        TagLib::Tag *mediaTag = mediaFile.tag();
        qDebug()<<mediaTag->album().toCString();
        qDebug()<<mediaTag->artist().toCString();
        qDebug()<<mediaTag->genre().toCString();
        qDebug()<<mediaTag->title().toCString();
    }
}

QString MediaExtractor::getTitle(QString mediaPath)
{
    QUrl mediaURL(mediaPath);
    QString localFile = mediaURL.toLocalFile();
    QString title;
    TagLib::FileRef mediaFile(localFile.toStdString().c_str());
    if(!mediaFile.isNull() && mediaFile.tag())
    {
        TagLib::Tag *mediaTag = mediaFile.tag();
        title = mediaTag->title().toCString();
        if(title.isEmpty() | title.isNull())
            title = mediaURL.fileName();
        qDebug()<<title;
    }
    return title;
}

QString MediaExtractor::getArtist(QString mediaPath)
{
    QUrl mediaURL(mediaPath);
    QString localFile = mediaURL.toLocalFile();
    QString artist;
    TagLib::FileRef mediaFile(localFile.toStdString().c_str());
    if(!mediaFile.isNull() && mediaFile.tag())
    {
        TagLib::Tag *mediaTag = mediaFile.tag();
        artist = mediaTag->artist().toCString();
        if(artist.isEmpty() | artist.isNull())
            artist = "unknown";
        qDebug()<<artist;
    }
    return artist;
}

void MediaExtractor::getAlbumCover(QString mediaPath)
{

}
