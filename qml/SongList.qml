import QtQuick 2.0
import Qt.labs.folderlistmodel 2.2
import VPlayApps 1.0
import QtMultimedia 5.8

AppListView
{
    id: listview
    signal songIndex(int index, var row)
    signal songPath(string path)
    readonly property string linuxPath: "/root/Music"
    readonly property string nomusicText: "<b>Place your music files to internal storage's Music folder</b>"
    property variant androidPath: ["file:///sdcard/Music","file:///sdcard","file:///sdcard/Download",
                                   "file:///sdcard/UcDownloads","file:///storage/sdcard1",
                                   "file:///storage/sdcard1/Music","file:///storage/sdcard1/Download",
                                   "file:///storage/sdcard1/UcDownloads","file:///storage/sdcard1/shareit/audio",
                                   "file:///sdcard/shareit/audio"]
    property real xAxis: (width - optionMenu.width)/2
    property real yAxix: (height - optionMenu.height)/2
    property real opWidth: (width) - (width/5)
    property real opHeight: height/2
    property real tabletSize: sp(35)
    property real mobileSize

    Repeater
    {
        model:
        {
            if(Qt.platform.os === "android")
                return androidPath
            if(Qt.platform.os === "linux")
                return [linuxPath]
        }

        delegate: Item
        {
            Repeater
            {
                model: FolderListModel
                {
                    folder: modelData
                    caseSensitive: false
                    showDirs: false
                    nameFilters: ["*.mp3","*.wav","*.ogg","*.3gpp","*.mp4a"]
                }
                delegate: Item
                {
                    Text
                    {
                        Component.onCompleted:
                        {
                            var url = fileURL.toString()
                            var artist = mediaextractorId.getArtist(fileURL)
                            var songTitle = mediaextractorId.getTitle(fileURL)
                            var itm = {"fileName":songTitle,"fileURL":url,"artist":artist}
                            allSongModel.append( itm )
                            tempModel.append(itm)
                            mediaextractorId.extractAlbumCover(fileURL)
                        }
                    }
                }
            }
        }
    }

    model: allSongModel
    delegate: SimpleRow
              {
                  id: simplerowDel
                  property string fullpath
                  text: fileName.toString()
                  detailText: artist
                  fullpath: fileURL
                  iconSource: IconType.music
                  style.backgroundColor: "#212121"
                  style.dividerColor: "#E6000000"
                  style.textColor: "white"
                  style.detailTextColor: "#b2b2b2"//"white"//"#E91E63"
                  style.fontSizeDetailText:
                  {
                      if(Qt.platform.os !== "android")
                      {
                        if(tablet)
                            return sp(20)
                        else
                            return sp(15)
                      }
                  }

                  height: dp(70)
                  Component.onCompleted:
                  {
                      listview.songPath(fullpath)
                      mobileSize = style.fontSizeText
                  }
                  RippleMouseArea
                  {
                      id: pressarea
                      anchors.fill: parent
                      centerAnimation: true
                      pressedDuration: 800
                      circularBackground: false
                      onPressAndHold:
                      {
                          console.log("press and hold")
                          selectedSongIndex = index
                          selectedSongPath = fullpath
                          selectedSongName = text
                          optionMenu.open()
                      }

                      onClicked:
                      {
                          listview.songIndex(index, parent)
                          iconSource = IconType.play
                      }
                  }
              }

    opacity: 0.7
    emptyText.text: nomusicText
    emptyText.color: "purple"

    SongOptions
    {
        id: optionMenu
        y: yAxix
        x: xAxis
        width: opWidth
        height: opHeight
    }
}
