#ifndef MEDIA_EXTRACTOR_H
#define MEDIA_EXTRACTOR_H

#include <QObject>
#include <QString>
#include <QUrl>
#include <iostream>
#include <iomanip>
#include <string>
#include <stdio.h>

#include <taglib/fileref.h>
#include <taglib/tag.h>
#include <taglib/tpropertymap.h>
#include <taglib/attachedpictureframe.h>
#include <taglib/id3v1tag.h>
using namespace TagLib;
using namespace std;

class MediaExtractor : public QObject
{
    Q_OBJECT
public:
    explicit MediaExtractor(QObject *parent = nullptr);
    Q_INVOKABLE void mediaMetaData(QString mediaPath);
    Q_INVOKABLE QString getTitle(QString mediaPath);
    Q_INVOKABLE QString getArtist(QString mediaPath);
    Q_INVOKABLE void getAlbumCover(QString mediaPath);
};

#endif // MEDIA_EXTRACTOR_H
