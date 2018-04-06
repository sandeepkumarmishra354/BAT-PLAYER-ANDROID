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
    property variant androidPath: ["file:///sdcard/Music","file:///sdcard","file:///sdcard/Downloads",
                                   "file:///sdcard/UcDownloads","file:///storage/sdcard1",
                                   "file:///storage/sdcard1/Music","file:///storage/sdcard1/Downloads",
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
                            var itm = {"fileName":fileName,"fileURL":url}
                            allSongModel.append( itm )
                            tempModel.push(itm)
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
                  fullpath: fileURL
                  iconSource: IconType.music
                  style.backgroundColor: "#212121"
                  style.dividerColor: "#66000000"
                  style.textColor: "white"
                  style.fontSizeText:
                  {
                      if(tablet)
                        return tabletSize
                      else
                        return mobileSize
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
                      backgroundColor: "#E5000000"
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
