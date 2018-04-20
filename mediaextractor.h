#ifndef MEDIA_EXTRACTOR_H
#define MEDIA_EXTRACTOR_H

#include <QObject>
#include <QString>
#include <QStringList>
#include <QUrl>
#include <QFileInfoList>
#include <iostream>
#include <iomanip>
#include <string>
#include <stdio.h>
#include <cstdio>
#include <taglib/fileref.h>
#include <taglib/tag.h>
#include <taglib/tpropertymap.h>
#include <taglib/id3v1tag.h>
#include <taglib/id3v2tag.h>
#include <taglib/mpegfile.h>
#include <taglib/id3v2frame.h>
#include <taglib/id3v2header.h>
#include <taglib/attachedpictureframe.h>
using namespace TagLib;
using namespace std;

class MediaExtractor : public QObject
{
    Q_OBJECT
private:
    //QStringList mediaCoverArtPathList;
    QFileInfoList cvrArtListInfo;
    const QString androidPathCoverArtList = "file:///sdcard/.BATPLAYER";
    const QString androidPathCoverArt = "file:///sdcard/.BATPLAYER/.CoverArt";
    const QString linuxPath = "/root/CoverArt";
    QString pathToList;
    QString cvrArtPath;
    QString svPath;
public:
    explicit MediaExtractor(QObject *parent = nullptr);
    ~MediaExtractor();
    Q_INVOKABLE QString getTitle(QString mediaPath);
    Q_INVOKABLE QString getArtist(QString mediaPath);
    Q_INVOKABLE void extractAlbumCover(QString mediaPath);
    Q_INVOKABLE QString getAlbumCover(QString mediaTitle);
private slots:
    void initCvrArtList();
};

#endif // MEDIA_EXTRACTOR_H
