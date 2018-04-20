#include <QDebug>
#include <QImage>
#include <QFile>
#include <QDir>
#include <QIODevice>
#include <QTextStream>
#include "mediaextractor.h"

// Constructor
MediaExtractor::MediaExtractor(QObject *parent) : QObject(parent)
{
    #ifdef Q_OS_LINUX
        cvrArtPath = linuxPath;
        svPath = cvrArtPath;
        QDir folder(cvrArtPath);
        if(!folder.exists())
            folder.mkdir(cvrArtPath);
    #endif

    #ifdef Q_OS_ANDROID
        QUrl url(androidPathCoverArtList);
        cvrArtPath = url.toLocalFile();
        QDir fldr(cvrArtPath);
        if(!fldr.exists())
            fldr.mkdir(cvrArtPath);
        url = androidPathCoverArt;
        cvrArtPath = url.toLocalFile();
        fldr.setPath(cvrArtPath);
        if(!fldr.exists())
            fldr.mkdir(cvrArtPath);
        svPath = cvrArtPath;
    #endif

    initCvrArtList(); // initializes list of cover arts
}

void MediaExtractor::initCvrArtList()
{
    QDir dir(cvrArtPath);
    cvrArtListInfo.clear();
    cvrArtListInfo = dir.entryInfoList(QDir::Files);
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
    }
    return artist;
}

void MediaExtractor::extractAlbumCover(QString mediaPath)
{
    static const char *IdPicture = "APIC";
    bool already = false;
    QString title;
    QUrl mediaURL(mediaPath);
    QString localFile = mediaURL.toLocalFile();

    TagLib::FileRef mediaFile(localFile.toStdString().c_str());
    if(!mediaFile.isNull() && mediaFile.tag())
    {
        TagLib::Tag *mediaTag = mediaFile.tag();
        title = mediaTag->title().toCString();
        if(title.isEmpty() | title.isNull())
            title = mediaURL.fileName();
        int index = title.lastIndexOf(".");
        title = title.mid(0,index);
        title.prepend(svPath+"/");
        foreach(QFileInfo itm, cvrArtListInfo)
        {
            if(itm.absoluteFilePath() == title)
            {
                already = true;
                break;
            }
        }
    }

    if(!already)
    {
        TagLib::MPEG::File mpegFile(localFile.toStdString().c_str());
        TagLib::ID3v2::Tag *id3v2tag = mpegFile.ID3v2Tag();
        TagLib::ID3v2::FrameList Frame;
        TagLib::ID3v2::AttachedPictureFrame *PicFrame;
        void *SrcImage;
        unsigned long Size;

        if ( id3v2tag )
        {
            Frame = id3v2tag->frameListMap()[IdPicture];
            if (!Frame.isEmpty() )
            {
                for(TagLib::ID3v2::FrameList::ConstIterator it = Frame.begin(); it != Frame.end(); ++it)
                {
                    PicFrame = (TagLib::ID3v2::AttachedPictureFrame *)(*it);
                    if ( PicFrame->type() == TagLib::ID3v2::AttachedPictureFrame::FrontCover)
                    {
                        Size = PicFrame->picture().size();
                        SrcImage = malloc ( Size );
                        if ( SrcImage )
                        {
                            FILE *jpegFile;
                            jpegFile = fopen(title.toStdString().c_str(),"wb");

                            memcpy ( SrcImage, PicFrame->picture().data(), Size );
                            fwrite(SrcImage,Size,1, jpegFile);
                            fclose(jpegFile);
                            free( SrcImage );
                            //mediaCoverArtPathList.append(title);
                        }
                    }
                }
            }

        }
    }

    initCvrArtList();
}

QString MediaExtractor::getAlbumCover(QString mediaTitle)
{
    QString path;
    #ifdef Q_OS_LINUX
        path = linuxPath+"/";
    #endif
    #ifdef Q_OS_ANDROID
        path = androidPathCoverArt+"/";
    #endif
    QString cvrPath = "";
    int index = mediaTitle.lastIndexOf(".");
    mediaTitle = mediaTitle.mid(0,index);
    foreach(QFileInfo itm, cvrArtListInfo)
    {
        if(itm.fileName().contains(mediaTitle))
        {
            cvrPath = mediaTitle.prepend(path);
            break;
        }
    }
    return cvrPath;
}

MediaExtractor::~MediaExtractor()
{
    qDebug()<<"C++ Destructor";
}
